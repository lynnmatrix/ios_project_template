//
//  RequestDataSourcePreparation.m
//  
//
//  Created by Yiming Lin on 11/7/11.
//  Copyright (c) 2011 papa. All rights reserved.
//

#import "RequestConf.h"
#import "RequestDataSource.h"
#import "Config.h"

@implementation APIStatus
@synthesize statusCode;
@end

@implementation RequestConf
+ (void) prepareRequestSignatureMap{
    RequestDataSource* requestSource = [RequestDataSource sharedRequestDataSource];
    requestSource.server = server;
    [requestSource mapApi:API_LOG toName:@"log"];
    [requestSource mapApi:API_LOG toParams:@"pageView,clickPos,crashReport"]; 
    
    [requestSource mapApi:API_OPENAPP toName:@"openapp"];
    [requestSource mapApi:API_OPENAPP toParams:@"maid,md,phoneNumber"];
}

//- (NSString *) getMethod : (int) method
//{
//    switch (method) {
//        case API_NEWUSER:
//            return @"newuser";
//        case API_BINDNTES:
//            return @"bindntes";
//        case API_BINDSINA:
//            return @"bindsina";
//        case  API_MYRATES:
//            return @"myrates";
//        case API_RATE:
//            return @"rate";
//        case API_RECOMMEND:
//            return @"recommend";
//        case API_RESTINFO:
//            return @"restinfo";
//        case API_RESTCOMMENTS:
//            return @"restaurantcomments";
//        case API_COMMENT:
//            return @"comment";
//        case API_USERCOMMENTS:
//            return @"usercomments";
//        case API_MYFAVORS:
//            return @"myfavors";
//        case API_SETUSERIINFO:
//            return @"setuserinfo";
//        case API_FAVOR:
//            return @"favor";
//        case API_UNFAVOR:
//            return @"unfavor";
//        case API_COMPLAINT:
//            return @"complaint";
//        case API_SUGGEST:
//            return @"suggest";
//        case API_LOG:
//            return @"log";
//        case API_CHECKUPDATE:
//            return @"checkupdate";
//        case API_OPENAPP:
//            return ;
//        case API_BOARD:
//            return @"board";
//        case API_PERSONALIZE:
//            return @"personalize";
//        default:
//            break;
//    }
//    return nil;
//}

//- (NSString *) getParams : (int) method
//{
//    switch (method) {
//        case API_NEWUSER:
//            return @"";
//        case API_BINDNTES:
//            return @"user,pass,login";
//        case API_BINDSINA:
//            return @"vericode,login";
//        case API_MYRATES:
//            return @"startTime,startPlaceId,min,max,len";
//        case API_RATE:
//            return @"id,rate";
//        case API_RECOMMEND:
//            return @"notVisited,sort,city,dist,lo,la,minPay,maxPay,start,len,q,style";
//        case API_RESTINFO:
//            return @"id";
//        case API_RESTCOMMENTS:
//            return @"placeId,startCommentId,count";
//        case API_COMMENT:
//            return @"id,content,withrate";
//        case API_USERCOMMENTS:
//            return @"startCommentId,count";
//        case API_MYFAVORS:
//            return @"startTime,startPlace,len";
//        case API_SETUSERIINFO:
//            return @"name,home,company,traffic";
//        case API_FAVOR:
//            return @"id";
//        case API_UNFAVOR:
//            return @"id";
//        case API_COMPLAINT:
//            return @"content,rate";
//        case API_SUGGEST:
//            return @"q,len,lo,la,dist,city";
//        case API_LOG:
//            return @"pageView,clickPos,crashReport";
//        case API_CHECKUPDATE:
//            return @"ver";
//        case API_OPENAPP:
//            return ;
//        case API_BOARD:
//            return @"type,id,rest,count";
//        case API_PERSONALIZE:
//            return @"city,lo,la,start,len";
//        default:
//            break;
//    }
//    return nil;
//}
//
//- (Class) getReturnClass : (int) method
//{
//    switch (method) {
//        case API_NEWUSER:
//            return [MsgUserInfo class];
//        case API_BINDNTES:
//            return [MsgBindResult class];
//        case API_BINDSINA:
//            return [MsgBindResult class];
//        case API_MYRATES:
//            return [MsgRestInfos class];
//        case API_RATE:
//            return nil;
//        case API_RECOMMEND:
//            return [MsgRestInfos class];
//        case API_RESTINFO:
//            return [MsgRestInfo class];
//        case API_RESTCOMMENTS:
//            return [MsgRestComments class];
//        case API_COMMENT:
//            return [MsgRestComment class];
//        case API_USERCOMMENTS:
//            return [MsgRestComments class];
//        case API_MYFAVORS:
//            return [MsgRestInfos class];
//        case API_FAVOR:
//            return nil;
//        case API_UNFAVOR:
//            return nil;
//        case API_COMPLAINT:
//            return nil;
//        case API_SUGGEST:
//            return [MsgSuggestions class];
//        case API_CHECKUPDATE:
//            return [MsgUpdateInfo class];
//        case API_SETUSERIINFO:
//            return [MsgUserInfo class];
//        case API_BOARD:
//            return [MsgBoard class];
//        case API_PERSONALIZE:
//            return [MsgRestInfos class];
//        default:
//            break;
//    }
//    return nil;
//}
@end
