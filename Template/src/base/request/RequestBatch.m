//
//  RequestBatch.m
//  
//
//  Created by Yiming Lin on 11/9/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "RequestBatch.h"
#import "RequestDataSource.h"
#import "ExceptionType.h"

#import "Three20Core/TTDebugFlags.h"
#import "extThree20JSON/NSObject+YAJL.h"

@implementation RequestBatch

@synthesize requestArray = _requestArray;

- (id) init
{
    if(self = [super init])
    {
        _requestArray = [[NSMutableArray alloc] initWithCapacity : 2];
    }
    
    return self;
}

- (void) dealloc{
    TT_RELEASE_SAFELY(_requestArray);
    [super dealloc];
}

+ (RequestBatch *) createRequestBatch
{
    return [[[RequestBatch alloc] init] autorelease];
}

- (void) addRequest : (Request *) request
{
    [_requestArray addObject : request];
}

- (NSString *) formUrl
{
    if (_requestArray.count == 0) {
        TTDWARNING(@"request array is null");
        return nil;
    }
    
    NSMutableArray* methodArray = [NSMutableArray arrayWithCapacity:1];
    for (Request* request in self.requestArray) {
        [methodArray addObject:[request getRequest]];
    }
    
    NSString* methods = [methodArray yajl_JSONString];
    
    TTDCONDITIONLOG(TTDFLAG_URLREQUEST, @"%@", methods);
    methods = [methods urlEncoded];
    
    NSString * url = [[[NSString alloc] initWithFormat : @"%@api?m=%@", 
                       [[RequestDataSource globalRequestDataSource] server],
                       methods] autorelease];
    
    return url;
 
}

- (NSDictionary*) parseJSONResponse:(TTURLJSONResponse*) response
                             status:(NSMutableDictionary**) statusDict{

    NSMutableDictionary* result = [[[NSMutableDictionary alloc] init] autorelease];
    
    for (int index =0;index<self.requestArray.count;++index) {
        Request* request = [self.requestArray objectAtIndex:index];
        NSMutableDictionary* status = [[NSMutableDictionary alloc] initWithCapacity:2];
        
        NSString* requestName = [[RequestDataSource globalRequestDataSource] getName:request.type];

        NSArray* singleResponse = [response.rootObject objectAtIndex:index];
        
        if (nil == singleResponse) {
            NSString* reason = [NSString stringWithFormat:@"No matched response for %@",requestName];
            TTDERROR(@"%@",reason);
            @throw [NSException exceptionWithName:ExceptionNoMatchResponse
                                           reason:reason
                                         userInfo:nil];
        }

        id data = [request parseJSONResponse:singleResponse
                                      status:&status];
        TTDCONDITIONLOG(TTDFLAG_URLREQUEST, @"%@ parsed",requestName);
        NSString* key = [NSString stringWithFormat:@"%d",request.type];
        if (data) {
            [result setObject:data
                       forKey:key];
        }
        [*statusDict setObject: status 
                        forKey: key];
    }
    return result;


}

- (NSDictionary*) parseResponse:(PBCodedInputStream *)input
{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:3];
    
    for (Request* request in _requestArray) {
        id data = [request parseResponse:input];
        TTDINFO(@"%@ parsed",[DSRequestUtility getMethod:request.type]);
        if (data) {
            [result setObject:data
                       forKey:[NSString stringWithFormat:@"%d",request.type]];
        }
    }
    return result;
}

- (void) clearRequests
{
    [self.requestArray removeAllObjects];
}

@end


