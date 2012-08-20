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
    
    [requestSource mapApi:API_NEWUSER toName:@"newuser"];
    
    [requestSource mapApi:API_RESTINFO toName:@"restinfo"];
    [requestSource mapApi:API_RESTINFO toParams:@"id"];
    
    [requestSource mapApi:API_RECOMMEND toName:@"recommend"];
    [requestSource mapApi:API_RECOMMEND toParams:@"notVisited,sort,city,dist,lo,la,minPay,maxPay,start,len,q,style,type,view"];
    [requestSource mapApi:API_RECOMMEND toReturnClass:[MsgRestInfos class]];
    
    [requestSource mapApi:API_SEARCH toName:@"search"];
    [requestSource mapApi:API_SEARCH toParams:@"q,start,len,lo,la,city"];
    [requestSource mapApi:API_SEARCH toReturnClass:[MsgRestInfos class]];
}

@end
