//
//  RequestBatch.h
//  
//
//  Created by Yiming Lin on 11/9/11.
//  Copyright (c) 2011 . All rights reserved.
//
#import "Request.h"

@class Request;
@class CubeStatRequest;

@interface RequestBatch : NSObject
{
    NSMutableArray *_requestArray;
}

@property (nonatomic, retain) NSMutableArray *requestArray;


/**
	create new instance of DSRequestBatch
	@returns new instance of DSRequestBatch 
 */
+ (RequestBatch *) createRequestBatch;


/**
	add request to batch
 @param requst: request to be added
 */
- (void) addRequest : (Request *) request;

/**
	form url with requsts in batch
	@returns url string
 */
- (NSString *) formUrl;


/**
	parse response
	@param input :data to be parsed
	@returns dictionary contains parsed response for every api with key for method 
 */
- (NSDictionary*) parseResponse:(PBCodedInputStream *)input;

- (NSDictionary*) parseJSONResponse:(id) input
                             status:(NSMutableDictionary**) status;


/**
	clear requests in batch
 */
- (void) clearRequests;

@end