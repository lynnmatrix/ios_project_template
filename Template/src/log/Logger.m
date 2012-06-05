//
//  Logger.m
//  
//
//  Created by Yiming Lin on 1/11/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import "Logger.h"
#import "RequestBatch.h"
#import "RequestConf.h"
#import "DebugFlags.h"
#import "Utility.h"

@implementation Logger

- (void) configRequest
{
    TTDASSERT(_request);
    if (nil==_request) {
        return;
    }
    _request.httpMethod = @"POST";
    _request.timeoutInterval = 10;
    _request.cachePolicy = TTURLRequestCachePolicyNetwork;
    _request.cacheExpirationAge = TT_DEFAULT_CACHE_INVALIDATION_AGE;
}

- (id) init
{
    if (self = [super init]) {
        _requestBatch = [[RequestBatch alloc] init];
        _request = [TTURLRequest request];
        [self configRequest];
    }
    return self;
}

+ (Logger*) defaultLogger
{
    static Logger* defaultLogger = nil;
    if (nil == defaultLogger) {
        defaultLogger = [[Logger alloc] init];
    }
    return defaultLogger;
}

//reset pageView
- (void)updateLogRequest:(Request *)request pageView:(NSString *)pageView
{
    NSArray* paramNames = [Request getParamArray:API_LOG];
    
    //reset pageView
    NSString* pageViewName = [paramNames objectAtIndex:0];
    TTDASSERT([pageViewName isEqualToString:@"pageView"]);
    
    NSString* pageViewStr = [request.params objectForKey:pageViewName];
    if (pageViewStr.length>0) {
        pageViewStr=[pageViewStr stringByAppendingFormat:@",%@",pageView];
    }else {
        pageViewStr = pageView;
    }
    
    [request.params setObject:pageViewStr forKey:pageViewName];
}

//reset clickPos
- (void)updateLogRequest:(Request *)request clickPos:(int)clickPos
{
    NSArray* paramNames = [Request getParamArray:API_LOG];
    NSString* clickPosName = [paramNames objectAtIndex:1];
    TTDASSERT([clickPosName isEqualToString:@"clickPos"]);
    
    NSString* clickPosStr = [request.params objectForKey:clickPosName];
    if (clickPosStr.length>0) {
        clickPosStr=[clickPosStr stringByAppendingFormat:@",%d",clickPos];
    }else {
        clickPosStr = [NSString stringWithFormat:@"%d",clickPos];
    }
    
    [request.params setObject:clickPosStr forKey:clickPosName];
}

- (void) addLogWithPageView:(NSString*)pageView
                   clickPos:(int)clickPos
{
    TTDCONDITIONLOG(DebugFlagLog, @"add log with click positon %d",clickPos);
    
    Request* logRequest = nil;
    for (Request* request in _requestBatch.requestArray) {
        if (API_LOG==request.type) {
            logRequest =request;
            break;
        }
    }
    
    if (logRequest) {
        TTDASSERT(API_LOG == logRequest.type);
        
        [self updateLogRequest:logRequest
                    pageView:pageView];
        
        [self updateLogRequest:logRequest
                    clickPos:clickPos];
    }else {
        Request* request = [Request requestWithMethod:API_LOG
                                               params:
                            pageView,
                            [NSString stringWithFormat:@"%d",clickPos],
                            EMPTYPARAMVALUE,
                            nil];
        [_requestBatch addRequest:request];
    }
}

- (void) addLogWithPageView:(NSString*)pageView
{
    TTDCONDITIONLOG(DebugFlagLog, @"add log %@",pageView);
    
    //find log request
    Request* LogRequest = nil;
    for (Request* request in _requestBatch.requestArray) {
        if (API_LOG==request.type) {
            LogRequest =request;
            break;
        }
    }
    
    if (LogRequest) {
        TTDASSERT(API_LOG == LogRequest.type);
        
        [self updateLogRequest:LogRequest
                    pageView:pageView];
    }else {
        
        Request* request = [Request requestWithMethod:API_LOG
                                               params:
                            pageView,
                            EMPTYPARAMVALUE,
                            EMPTYPARAMVALUE,
                            nil];
        [_requestBatch addRequest:request];
    }
    
    
}

- (void) addDeviceLog
{
    TTDCONDITIONLOG(DebugFlagLog, @"add device log");
    UIDevice * device = [UIDevice currentDevice];
    NSString* os =[NSString stringWithFormat:@"%@ %@",device.systemName,device.systemVersion];
    NSString* md = TTDeviceModelName();
    
    Request* request = [Request requestWithMethod:API_OPENAPP
                                           params:
                        os,
                        md,
                        EMPTYPARAMVALUE,
                        nil];
    [_requestBatch addRequest:request];
}

- (void) addCrashReport:(NSString* ) report{
    Request* request = [Request requestWithMethod:API_LOG
                                           params:EMPTYPARAMVALUE,EMPTYPARAMVALUE,report, nil];
    [_requestBatch addRequest:request];
}


- (void) sendLog
{
    TTDCONDITIONLOG(DebugFlagLog, @"send log");
    NSString *url;
    url = [_requestBatch formUrl];
    
    if (nil==url||url.length == 0) {
        return;
    }
    
    url = [NSString stringWithFormat:@"%@%@",url,[Utility getSuffixOfUrl]];
    
    [_request setUrlPath:url];
    [_request send];
    [_requestBatch clearRequests];
}
@end
