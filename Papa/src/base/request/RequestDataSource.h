//
//  RequestDataSource.h
//  Papa
//
//  Created by Yiming Lin on 12-4-24.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

@protocol RequestDataSource

@required
/**
 get string of method name for give method code
 @returns string of method name
 */
- (NSString *) getName : (int) api;

/**
 get string of params for given method
 @returns string of param with ','seperated
 */
- (NSString *) getParams : (int) api;

@optional
/**
 get class of returned instance for given method
 @returns class of returned instance
 */
- (Class) getReturnClass : (int) api;

@end

@interface  RequestDataSource: NSObject<RequestDataSource>{
    NSMutableDictionary* _apiNameDict;
    NSMutableDictionary* _apiParamsDict;
}
@property (nonatomic, copy) NSString* server;

+ (RequestDataSource*) defaultRequestDataSource;
- (void) mapApi:(int) api toName:(NSString*)methodName;
- (void) mapApi:(int)api toParams:(NSString*) params;
- (void) removeNameOfApi:(int) api;
- (void) removeParamsOfApi:(int) api;
@end