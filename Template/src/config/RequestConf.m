//
//  RequestDataSourcePreparation.m
//  
//
//  Created by Yiming Lin on 11/7/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "RequestConf.h"
#import "RequestDataSource.h"
#import "Config.h"

@implementation APIStatus
@synthesize statusCode;
@end

@implementation RequestConf
+ (void) configRequestSignatureMap{
    RequestDataSource* requestSource = [RequestDataSource globalRequestDataSource];
    requestSource.server = server;
    [requestSource mapApi:API_LOG toName:@"log"];
    [requestSource mapApi:API_LOG toParams:@"pageView,clickPos,crashReport"]; 
    
    [requestSource mapApi:API_OPENAPP toName:@"openapp"];
    [requestSource mapApi:API_OPENAPP toParams:@"maid,md,phoneNumber"];
}

@end
