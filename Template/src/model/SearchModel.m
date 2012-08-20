//
//  SearchModel.m
//  Fanfan
//
//  Created by Lin Yiming on 7/23/12.
//  Copyright (c) 2012 Lin Yiming. All rights reserved.
//

#import "SearchModel.h"
#import "PBArrayConverter.h"
#import "RequestConf.h"
#import "MOLocator.h"

@interface SearchModel ()
@property (nonatomic, strong) NSMutableArray* paramArray;
@property (nonatomic, strong) NSString* key;
@end

@implementation SearchModel

@synthesize paramArray = _paramArray;
@synthesize key  = _key;

- (id) initWithKey:(NSString*) key;
{
    self = [super init];
    if (self) {
        self.methodWithMore = API_SEARCH;
        self.resultsPerPage = 20;
        [self setWillBlock:NO];
        [self setWillCancelPreRequest:YES];
        _paramArray = nil;
        self.key = key;
    }
    return self;
}
- (void) prepareParamArray
{
    NSString* longitude = [[MOLocator sharedMOLocator] longitude];
    NSString* latitude  = [[MOLocator sharedMOLocator] latitude];
    if (!longitude||latitude) {
        
        longitude = @"";
        latitude = @"";
    }
    
    NSString* city = @"北京";
    self.paramArray= [NSMutableArray arrayWithObjects:
                      self.key,
                      @"0", 
                      @"21",
                      longitude,
                      latitude,
                      city?city:EMPTYPARAMVALUE,
                      nil];
}

- (void) prepareRequests
{
    [self prepareParamArray];
    if (_paramArray) {
        [self.paramArray replaceObjectAtIndex:1
                                   withObject:@"0"];
        
        [self setRequest:[Request requestWithMethod:API_SEARCH
                                         paramArray:self.paramArray]];
    }
}

- (void) prepareAppendRequest
{
    MsgRestInfos* restInfos = [self.responseDict objectForKey:[NSString stringWithFormat:@"%d",API_SEARCH]];
    int startIndex = restInfos.rests.count-1;
    
    [self.paramArray replaceObjectAtIndex:1
                               withObject:[NSString stringWithFormat:@"%d",startIndex]];
    
    [self.requestBatch clearRequests];
    [self setRequest:[Request requestWithMethod:API_SEARCH
                                     paramArray:self.paramArray]];
}

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
