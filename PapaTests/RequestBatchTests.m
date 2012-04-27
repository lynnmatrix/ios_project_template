//
//  RequestBatchTests.m
//  Papa
//
//  Created by Yiming Lin on 12-4-27.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "RequestBatchTests.h"
#import "RequestBatch.h"
#import "RequestDataSource.h"
#import "RequestConf.h"
#import "Config.h"

@implementation RequestBatchTests
- (void) setUp{
    [super setUp];
    
    [RequestConf configRequestSignatureMap];
    _batch = [[RequestBatch alloc] init];
}

- (void) testNewBatch{
    Request* request = [Request requestWithMethod:API_LOG params:@"main",EMPTYPARAMVALUE,EMPTYPARAMVALUE, nil];
    STAssertEquals((int)_batch.requestArray.count,0,nil);
    [_batch addRequest:request];
    STAssertEquals((int)_batch.requestArray.count,1,nil);
    
    NSString* url = [_batch formUrl];
    NSString* trueUrl = [NSString stringWithFormat:@"%@%@",server,@"api?m=%5B%5B%22log%22%2C%7B%22pageView%22%3A%22main%22%7D%5D%5D"];
    STAssertEqualObjects(url,trueUrl, nil);
}
@end
