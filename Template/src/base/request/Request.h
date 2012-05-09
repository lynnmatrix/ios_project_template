//
//  Request.h
//  
//
//  Created by Yiming Lin on 11/7/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <extThree20JSON/extThree20JSON.h>

@interface Request : NSObject
{
    int _type;
    NSString * _method;
    NSMutableDictionary * _params;
}
@property (nonatomic) int type;
@property (nonatomic, retain) NSString* method;
@property (nonatomic, retain) NSMutableDictionary * params;

/**
	create request with given method type code and params
    @param method method code @see DSRequestUtility.h
    @param params array of params
	@returns DSRequest instance
 */
+ (Request*) requestWithMethod:(int) method
                      paramArray:(NSArray*) params;


/**
 create request with given method type code and params
 @param method method code @see DSRequestUtility.h
 @param params ,ended with nil
 @returns DSRequest instance	
 */
+ (Request*) requestWithMethod:(int) method
                          params:(id) value1, ... NS_REQUIRES_NIL_TERMINATION;


/**
	get the parameter array for given method
    @param method code
	@returns paramter array
 */
+ (NSArray*) getParamArray:(int) method;


/**
	get the array of request with method and param array as its elements, 
 the array will be used to generate json
	@returns array of request 
 */
- (NSArray*) getRequest;


/**
	parse response
	@param input: data returned from network or other source
    @exception NSException when status is not STATUS_SUCCESS,reaon of exception is status message
            and userInfo contain status code for key "status"
	@returns parsed data
 */
//- (id) parseResponse:(PBCodedInputStream *)input;


/**
	parese response with the json format 
    @param input:
    @exception: 
	@returns parse data
 */
- (NSDictionary*) parseJSONResponse:(NSArray*) response
                             status:(NSMutableDictionary**) status;

@end


/**
	Default param set to request when no specified param
 */
@interface EmptyParamValue : NSObject {
}

/**
	get shared empty param value
	@returns shared empty param value
 */
+ (EmptyParamValue*) emptyParamValue;

@end

#define EMPTYPARAMVALUE ([EmptyParamValue emptyParamValue])
