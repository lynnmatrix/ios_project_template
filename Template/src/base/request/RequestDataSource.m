//
//  RequestDataSource.m
//  
//
//  Created by Yiming Lin on 12-4-24.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "RequestDataSource.h"

//global requestdatasource
static RequestDataSource* gRequestDataSource = nil;

@implementation RequestDataSource

@synthesize server = _server;

+ (RequestDataSource*) globalRequestDataSource{
    if (nil == gRequestDataSource) {
        gRequestDataSource = [[RequestDataSource alloc] init];
    }
    return gRequestDataSource;
}

- (id) init{
    if (self=[super init]) {
        _apiNameDict = [[NSMutableDictionary alloc] init];
        _apiParamsDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (NSString*) keyForApi:(int) api{
    return [NSString stringWithFormat:@"%d",api];
}

- (void) mapApi:(int) api toName:(NSString*)methodName{
    if (nil==methodName||[methodName isWhitespaceAndNewlines]) {
        TTDWARNING(@"invalid name '%@' for api %d",methodName,api);
        return;
    }
    
    [_apiNameDict setObject:methodName forKey:[self keyForApi:api]];
}

- (void) mapApi:(int)api toParams:(NSString*) params{
    if (nil==params||[params isWhitespaceAndNewlines]) {
        TTDWARNING(@"invalid params '%@' for api %d",params,api);
        return;
    }
    
    [_apiParamsDict setObject:params forKey:[self keyForApi:api]];
}

- (void) removeNameOfApi:(int) api{
    [_apiNameDict removeObjectForKey:[self keyForApi:api]];
}

- (void) removeParamsOfApi:(int) api{
    [_apiParamsDict removeObjectForKey:[self keyForApi:api]];
}

#pragma mark -
#pragma mark protocol RequestDataSource
- (NSString*) getName:(int)api{
    return [_apiNameDict objectForKey:[self keyForApi:api]];
}

- (NSString*) getParams:(int)api{
    return [_apiParamsDict objectForKey:[self keyForApi:api]];
}

@end
