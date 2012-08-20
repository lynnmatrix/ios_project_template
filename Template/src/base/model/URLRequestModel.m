//
//  URLRequestModel.m
//  
//
//  Created by Yiming Lin on 10/31/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "URLRequestModel.h"
#import "Config.h"
#import "TBGlobalErrorView.h"
#import "TBLoadingView.h"

#import "Three20Core/TTDebugFlags.h"
#import "DebugFlags.h"

#import "User.h"
#import "Utility.h"
#import "TimeUtility.h"
#import "Logger.h"
#import "CodedInputStream.h"
#import "RequestConf.h"

static int lastDelay = 0;

@interface URLRequestModel()
- (void) clearModel;
@end

@implementation URLRequestModel

@synthesize page =_page;
@synthesize resultsPerPage  = _resultsPerPage;

@synthesize requestBatch = _requestBatch;
@synthesize responseDict = _responseDict;
@synthesize statusDict = _statusDict;

@synthesize urlRequestCachePolicy;
@synthesize httpMethod;

@synthesize responseFormat = _responseFormat;

- (void)configRequest:(TTURLRequest*) request
{
    [request.delegates removeObject:self];

    [request.delegates addObject:self];
    
    request.httpMethod = self.httpMethod;

    request.cachePolicy = self.urlRequestCachePolicy;
    request.cacheExpirationAge = TT_DEFAULT_CACHE_INVALIDATION_AGE;
    
    id<TTURLResponse> response = nil;
    
    switch (self.responseFormat) {
        case FormatJSON:
            response = [[TTURLJSONResponse alloc] init];
            break;
            case FormatProtocolBuffer:
            response = [[TTURLDataResponse alloc] init];
        default:
            break;
    }
    request.response = response;
}

-(id) init
{
    if (self=[super init]) {
        _resultsPerPage = NSIntegerMax;
        _page = 1;
        self.requestBatch = [RequestBatch createRequestBatch];
        self.responseDict = [[NSMutableDictionary alloc] init];
        self.statusDict = [[NSMutableDictionary alloc] init];
        
        _willBlock = NO;
        _willCancelPreRequest = NO;
        _willShowLoading = YES;
        _willShowError = YES;
        _willShowFailure = YES;
        self.urlRequestCachePolicy = TTURLRequestCachePolicyNetwork;
        self.httpMethod = @"POST";
    }
    return self;
}

- (void) dealloc
{
    TTDCONDITIONLOG(DebugFlagDealloc, @"base model");
    [_request.delegates removeObject:self];
    [self.delegates removeObject:self];
}

#pragma mark -
#pragma mark TTModel
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (_willCancelPreRequest) {
        TTDCONDITIONLOG(TTDFLAG_URLREQUEST, @"cancel");
        [self cancel];
    }
    
    if (more) {
        _page++;
    }
    else {
        _page = 1;
    }
	NSString *url = [self getRequestURL:more];
        
    if (nil==url||url.length == 0) {
        return;
    }

    _request = [[TTURLRequest alloc] init];
    
    [self configRequest:_request]; 
    [_request setUrlPath:url];
    [_request send];

    [[Logger defaultLogger] sendLog];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTURLRequestDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    _reqestStartTimeSince2001 = CFAbsoluteTimeGetCurrent();
    if (_willBlock) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
    if (_willShowLoading) {
        [TBLoadingView showLoadingView:YES];
    }

    [super requestDidStartLoad:request];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    
    lastDelay = -1;
    if (_willBlock) {
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }

    if (_willShowLoading) {
        [TBLoadingView showLoadingView:NO];
    }
    if (_willShowError) {
        [TBGlobalErrorView showNetworkErrorView];
    }
    [super request:request didFailLoadWithError:error];
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
    
    lastDelay = CFAbsoluteTimeGetCurrent() - _reqestStartTimeSince2001;
    if (_willBlock) {
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }
    
    if (_willShowLoading) {
        [TBLoadingView showLoadingView:NO];
    }

    TTURLDataResponse* response = request.response;
    TTDASSERT([response.data isKindOfClass:[NSData class]]);
    
    if (response.data == nil)
    {
        TTDERROR(@"response.data is nil");
        @throw [NSException exceptionWithName:nil reason:nil userInfo:nil];
    }
    if (1==_page) {
        [self clearModel];
    }
    switch (self.responseFormat) {
        case FormatProtocolBuffer:{
            PBCodedInputStream * input = [PBCodedInputStream streamWithData:response.data];
            [self parseResponse:input];
            break;
        }
        case FormatJSON:
            [self parseJSONResponse:request.response];
            break;
        default:
            break;
    }
    
    [super requestDidFinishLoad:request];

}
#pragma mark -
#pragma mark public
- (void) addRequest:(Request* )request
{
    [_requestBatch addRequest:request];
}

- (void) addRequestWithMethod:(int) method
                       params:(id) value1,...
{
    va_list args;
    va_start(args, value1);
    
    NSMutableArray* paramArray = [NSMutableArray arrayWithCapacity:1]; 

    for (id arg = value1; arg != nil; arg = va_arg(args, id))
    {
        [paramArray addObject:arg];
    }
    va_end(args);
    
    Request* request = [Request requestWithMethod:method
                                           paramArray:paramArray];
    [self addRequest:request];
}

- (void) setRequest:(Request* )request
{
    [self.requestBatch clearRequests];
    [self addRequest:request];
}

- (void) setRequestWithMethod:(int) method
                       params:(id) value1,...
{
    [self.requestBatch clearRequests];
    
    va_list args;
    va_start(args, value1);
    
    NSMutableArray* paramArray = [NSMutableArray arrayWithCapacity:1]; 
    
    for (id arg = value1; arg != nil; arg = va_arg(args, id))
    {
        [paramArray addObject:arg];
    }
    va_end(args);
    
    Request* request = [Request requestWithMethod:method
                                           paramArray:paramArray];
    [self addRequest:request];
}

- (int) getModelCapacity
{
    return _page * _resultsPerPage;
}

- (void) setWillBlock: (BOOL) willBlock
{
    _willBlock = willBlock;
}
- (void) setWillCancelPreRequest: (BOOL) willCancelPreRequest
{
    _willCancelPreRequest = willCancelPreRequest;
}
- (void) setWillShowLoading:(BOOL) willShowLoading
{
    _willShowLoading = willShowLoading;
}

- (void) setWillShowError: (BOOL) willShowError
{
    _willShowError = willShowError;
}
- (void) setWillShowFailure: (BOOL) willShowFailure
{
    _willShowFailure = willShowFailure;
}

#pragma -
#pragma private methods

//clear data when refresh data returned
- (void)clearModel {
    [self.responseDict removeAllObjects];
}

- (void) parseJSONResponse:(TTURLJSONResponse*) response{
    
    @try {
        NSMutableDictionary* status = 
        [[NSMutableDictionary alloc] initWithCapacity:self.requestBatch.requestArray.count];
        
        NSDictionary* result = [_requestBatch parseJSONResponse:response
                                                         status:&status];
        if (nil == result) {
            TTDWARNING(@"null response");
        }
        [self.responseDict addEntriesFromDictionary:result];
        self.statusDict = status;
    }
    @catch (NSException *exception) {
        TTDINFO(@"thow exception");
        if (_willShowFailure) {
            [TBGlobalErrorView showRequestFailureView];
        }
    }
}

- (void)parseResponse:(PBCodedInputStream *)input 
{
    @try {
        NSDictionary * result = [_requestBatch parseResponse:input];
        if (result==nil) {
            TTDWARNING(@"null response");
        }
        [self.responseDict addEntriesFromDictionary:result];
    }
    @catch (NSException *exception) {
        TTDINFO(@"throw exception");
        MsgApiStatus* status = [exception.userInfo objectForKey:@"status"];
        if (nil!=status) {
            TTDERROR(@"exception:%i,%@",status.code,status.message);
            [self.responseDict setValue:status
                                 forKey:@"status"];
        }
        
        if (_willShowFailure) {
            [TBGlobalErrorView showRequestFailureView];
        }
    }
}

- (NSString *) getSuffix
{
    NSString* lastDelayStr = [NSString stringWithFormat:@"&lastDelay=%d",lastDelay];
    NSString* suffix = [[Utility getSuffixOfUrl] stringByAppendingString:lastDelayStr];
    return suffix;
}

#pragma -
#pragma should be override by subclass

- (NSString *)getRequestURL:(BOOL)more
{
    NSString* url = [_requestBatch formUrl];

    if (nil == url||url.length==0) {
        return nil;
    }
    url = [NSString stringWithFormat:@"%@%@",url,[self getSuffix]];
    return url;
}
@end
