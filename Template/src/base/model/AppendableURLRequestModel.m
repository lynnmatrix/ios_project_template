//
//  AppendableURLRequestModel.m
//  
//
//  Created by Yiming Lin on 11/18/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "AppendableURLRequestModel.h"
#import "Config.h"

#import "User.h"
#import "TBGlobalErrorView.h"
#import "RequestDataSource.h"


@interface AppendableURLRequestModel () 
- (BOOL) hasMoreToLoad: (NSArray*)response;
@end

@implementation AppendableURLRequestModel

@synthesize methodWithMore = _methodWithMore;

- (id) init
{
    if (self = [super init]) {
        self.resultsPerPage = DefaultResultsPerPage;
        _methodWithMore =-1;
    }
    return self;
}

- (NSString *)getRequestURL:(BOOL)more
{
    [self.requestBatch.requestArray removeAllObjects];
    if (more) {
        [self prepareAppendRequest];
    }else {
        [self prepareRequests];
    }
    NSString* url = [self.requestBatch formUrl];
    if (nil == url||url.length==0) {
        return nil;
    }
    url = [NSString stringWithFormat:@"%@%@",url,[self getSuffix]];
    return url;
}

- (void) parseJSONResponse:(TTURLJSONResponse*) response{
    @try {
        NSMutableDictionary* status = 
        [[NSMutableDictionary alloc] initWithCapacity:self.requestBatch.requestArray.count];
        
        NSDictionary* result = [_requestBatch parseJSONResponse:response
                                                         status:&status];
        self.statusDict = status;

        self.hasNoMore = YES;
        
        if (nil == result) {
            TTDWARNING(@"null response");
        }else {
            NSString* method = [NSString stringWithFormat:@"%d",self.methodWithMore];
            NSDictionary* dataAppendable = [self.responseDict objectForKey:method];
            NSDictionary* dataReturn = [result objectForKey:method];
            
            NSString* key = (NSString*)dataAppendable.keyEnumerator.nextObject;

            TTDASSERT(1>dataAppendable.count);

            NSMutableArray* originData = [dataAppendable objectForKey:key];
            NSMutableArray* dataToAppend = [dataReturn objectForKey:key];
            
            if (self.page>1) {
                TTDASSERT(dataToAppend.count>0);
                [dataToAppend removeObjectAtIndex:0];
            }
            [originData addObjectsFromArray:dataToAppend];
            [result setValue:originData forKey:method];   
            
            
            if ([self hasMoreToLoad:dataToAppend]) {
                self.hasNoMore =NO;
            }
        }
        [self.responseDict addEntriesFromDictionary:result];
    }
    @catch (NSException *exception) {
        TTDINFO(@"thow exception");
        if (_willShowFailure) {
            [TBGlobalErrorView showRequestFailureView];
        }
    }
}


- (void)parseResponse:(PBCodedInputStream *)input 
{
    @try {
        NSDictionary * response = [self.requestBatch parseResponse:input];
        
        NSString *appendableKey=[NSString stringWithFormat:@"%d",self.methodWithMore];
        Class pbClass=[[RequestDataSource globalRequestDataSource] getReturnClass:self.methodWithMore];
        
        [self removeLastDataIfNeed];
        
        PBGeneratedMessage* dataAppenable = [self.responseDict objectForKey:appendableKey];
        PBGeneratedMessage* dataReturn = [response objectForKey:appendableKey];
        
        //warning ,since it's not abstract method 
        PBGeneratedMessage* dataMerged=[[[pbClass builderWithPrototype:dataAppenable]
                                         mergeFrom:dataReturn]
                                        build];
        [response setValue:dataMerged
                    forKey:appendableKey];
        
        [self.responseDict addEntriesFromDictionary:response];
        
        self.hasNoMore = YES;
        if ([self hasMoreToLoadProto:dataReturn]) {
            self.hasNoMore =NO;
        }
        
    }
    @catch (NSException *exception) {
        TTDINFO(@"throw exception");
        MsgApiStatus* status = [exception.userInfo objectForKey:@"status"];
        if (nil!=status) {
            TTDERROR(@"exception:%i,%@",status.code,status.message);
            [self.responseDict setValue:status
                                 forKey:@"status"];
        }
        
        if (_willShowFailure) {
            [TBGlobalErrorView showRequestFailureView];
        }
    }
}

#pragma -
#pragma private methods

- (BOOL) hasMoreToLoad:(NSArray *)response
{
    int count = response.count;
    
    /*由于返回数组无法删除最后一个元素，导致追加前的responceDict已经保留多出的一个元素，
     因此在下一次追加请求时应跳过该元素而且请求个数为resultPerPage,而非resultPerPage+1*/
    if (count >= self.resultsPerPage&&self.page>1) {
        return YES;
    }
    return NO;
}

#pragma -
#pragma private methods

- (BOOL) hasMoreToLoadProto: (PBGeneratedMessage*)response
{
    int count = [[self getPBArrayFromMessage:response] count];
    
    return  (count > self.resultsPerPage)?YES:NO;
}

- (void) removeLastDataIfNeed{
    
    if (self.page >1) {
        //其它页删除第一个返回元素
        NSString *appendableKey=[NSString stringWithFormat:@"%d",self.methodWithMore];
        PBGeneratedMessage* dataAppendable = [self.responseDict objectForKey:appendableKey];
        PBArray* pbArray = [self getPBArrayFromMessage:dataAppendable];
        
        PBAppendableArray* pbArrayToAppend = [PBAppendableArray arrayWithValueType:PBArrayValueTypeObject];
        
        int count = pbArray.count;
        for (int i =0; i< count-1; ++i) {
            [pbArrayToAppend addObject:[pbArray objectAtIndex:i]];
        }
        
        PBGeneratedMessage* result = [self getMessageFromPBArray:pbArrayToAppend];
        [self.responseDict setObject:result forKey:appendableKey];
    }
}


#pragma -
#pragma Must be overrided by subclass
- (void) prepareRequests
{}
- (void) prepareAppendRequest
{}

- (PBArray*) getPBArrayFromMessage: (PBGeneratedMessage*) message
{
    return nil;
}

- (PBGeneratedMessage*) getMessageFromPBArray:(PBArray*) array
{
    return nil;
}
@end
