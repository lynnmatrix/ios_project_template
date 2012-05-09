//
//  RequestTests.m
//  
//
//  Created by Yiming Lin on 12-4-25.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "RequestTests.h"
#import "Request.h"
#import "RequestConf.h"
#import "RequestDataSource.h"

@implementation RequestTests
- (void) setUp{
    [RequestConf configRequestSignatureMap];
}

- (void) testRequest{
    Request* request = [[Request alloc] init];
    STAssertEquals(request.type,0,nil);
    STAssertNil(request.method, nil);
    STAssertEquals((int)request.params.count, 0,nil);
}

- (void) testNewRequestWithArray{
    int api = 17;
    NSString* method = [[RequestDataSource globalRequestDataSource] getName:api];
    NSArray* paramKeys = [[[RequestDataSource globalRequestDataSource] getParams:api] componentsSeparatedByString:@","];
    
    NSMutableArray* paramValues = [NSMutableArray arrayWithArray:paramKeys];
    [paramValues replaceObjectAtIndex:0 withObject:EMPTYPARAMVALUE];
    
    Request* request = [Request requestWithMethod:api paramArray:paramValues];
    STAssertEquals(request.type, api,nil);
    STAssertEqualObjects(request.method, method,nil);
    STAssertEquals(request.params.count, paramKeys.count-1,nil);
    
    STAssertNil([request.params objectForKey:[paramKeys objectAtIndex:0]],nil);
    
    for (int i = 1; i<paramKeys.count; ++i) {
        NSString* key = [paramKeys objectAtIndex:i];
        STAssertEqualObjects([request.params objectForKey:key],key,nil);
    }

}
- (void) testNewRequstWithVaList{

    Request* request = [Request requestWithMethod:API_LOG params:@"main",EMPTYPARAMVALUE,EMPTYPARAMVALUE, nil];
    STAssertEquals(request.type, API_LOG,nil);
    STAssertEqualObjects(request.method, @"log",nil);
    STAssertEquals((int)request.params.count, 1,nil);
    NSString* pageView = [request.params objectForKey:@"pageView"];
    STAssertEqualObjects(pageView, @"main",nil);
}

- (void) testParseJsonResponse{
    NSArray* response = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"code",@"success",@"message", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"value",@"name", nil],nil];
    __strong NSMutableDictionary* status = [NSMutableDictionary dictionary];
    Request* request =[[Request alloc] init];
    NSDictionary* result = [request parseJSONResponse:response status:&status];
    
    STAssertEqualObjects([status objectForKey:@"code"], @"0",nil);
    STAssertEqualObjects([status objectForKey:@"message"], @"success",nil);
    STAssertEqualObjects([result objectForKey:@"name"], @"value",nil);
    
    
}

@end