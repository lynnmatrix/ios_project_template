//
//  RecommendModel.m
//  Template
//
//  Created by Lin Yiming on 8/20/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "RecommendModel.h"
#import "MOLocator.h"
#import "RequestConf.h"
#import "PBArrayConverter.h"

const int indexOfStartRestInParamArray = 8;
@interface RecommendModel ()
@property (nonatomic, strong) NSMutableArray* paramArray;
@end

@implementation RecommendModel
@synthesize paramArray =_paramArray;

- (void) prepareParamArray
{
    self.paramArray= [NSMutableArray arrayWithObjects:
                      @"true",
                      @"0",
                      @"北京",
                      @"500",
                      [[MOLocator sharedMOLocator] longitude]?[[MOLocator sharedMOLocator] longitude]:@"0",
                      [[MOLocator sharedMOLocator] latitude]?[[MOLocator sharedMOLocator] latitude]:@"0",
                      @"0",
                      @"200",
                      @"0", 
                      @"21",
                      @"正餐",
                      @"正餐",
                      @"0",
                      @"list",
                      nil];
}

- (void) prepareRequests
{
    [self prepareParamArray];
    if (_paramArray) {
        [self.paramArray replaceObjectAtIndex:indexOfStartRestInParamArray
                                   withObject:@"0"];
        
        [self setRequest:[Request requestWithMethod:API_RECOMMEND
                                         paramArray:self.paramArray]];
    }
}

- (void) prepareAppendRequest
{
    self.methodWithMore = API_RECOMMEND;
    MsgRestInfos* restInfos = [self.responseDict objectForKey:[NSString stringWithFormat:@"%d",API_RECOMMEND]];
    int startIndex = restInfos.rests.count-1;
    
    [self.paramArray replaceObjectAtIndex:indexOfStartRestInParamArray
                               withObject:[NSString stringWithFormat:@"%d",startIndex]];
    
    [self.requestBatch clearRequests];
    [self setRequest:[Request requestWithMethod:API_RECOMMEND
                                     paramArray:self.paramArray]];
}

#pragma mark PBArray~NSArray
- (PBArray*) getPBArrayFromMessage: (PBGeneratedMessage*) message
{
    PBArray* pbArray = [(MsgRestInfos*)message rests];
    return pbArray;
}

- (PBGeneratedMessage*) getMessageFromPBArray:(PBArray*) array
{
    
    NSArray* nsArray = [PBArrayConverter getNSArrayFromPBArray:array];
    PBGeneratedMessage* result = [[[MsgRestInfos builder] setRestsArray:nsArray]
                                  build];
    return result;
}

@end
