//
//  URLRequestModel.h
//  
//
//  Created by Yiming Lin on 10/31/11.
//  Copyright (c) 2011 papa. All rights reserved.
//

//network request
#import "RequestBatch.h"
#import <extThree20JSON/extThree20JSON.h>

@class RequestBatch;
@class Request;

typedef enum ResponseFormat {
    FormatJSON = 0,
    FormatProtocolBuffer = 1
} ResponseFormat;

@interface URLRequestModel : TTURLRequestModel {
    
@protected
    //for paging
    NSUInteger _page; // page of search request
    NSUInteger _resultsPerPage; // results per page, once the initial query is made

    //for web request and response
    RequestBatch* _requestBatch;  
    NSMutableDictionary* _responseDict;
    NSMutableDictionary* _statusDict;

    BOOL _willBlock;
    BOOL _willShowLoading;
    BOOL _willCancelPreRequest;
    BOOL _willShowError;
    BOOL _willShowFailure;

    TTURLRequest* _request;//network request
    
    /**
    	time when request starts,used to record lastDelay for log
     */
    NSTimeInterval _reqestStartTimeSince2001;
    
    ResponseFormat _responseFormat;
}

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger resultsPerPage;

@property (nonatomic, retain) RequestBatch* requestBatch;
@property (nonatomic, retain) NSMutableDictionary* responseDict;
@property (nonatomic, retain) NSMutableDictionary* statusDict;

//property of TTURLRequest
@property (nonatomic, assign) NSString* httpMethod;
@property (nonatomic, assign) TTURLRequestCachePolicy urlRequestCachePolicy;

@property (nonatomic, assign) ResponseFormat responseFormat;

- (void) addRequest:(Request* )request;
- (void) addRequestWithMethod:(int) method
                       params:(id) value1,...;

//clear request before setting new one
- (void) setRequest:(Request* )request;
- (void) setRequestWithMethod:(int) method
                       params:(id) value1,...;

- (int) getModelCapacity;

- (void) setWillBlock: (BOOL) willBlock;
- (void) setWillCancelPreRequest: (BOOL) willCancelPreRequest;
- (void) setWillShowLoading:(BOOL) willShowLoading;
- (void) setWillShowError: (BOOL) willShowError;//network error
- (void) setWillShowFailure: (BOOL) willShowFailure;//response is not valid

/**
	get suffix string for log ,which contain propertys about imei,lastDelay,ver,and vendor
	@returns suffix string
 */
- (NSString *) getSuffix;

#pragma -
#pragma should be override by subclass

- (NSString*) getRequestURL:(BOOL)more;
@end
