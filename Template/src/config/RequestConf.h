//
//  RequestDataSourcePreparation.h
//  
//
//  Created by Yiming Lin on 11/7/11.
//  Copyright (c) 2011 . All rights reserved.
//


/**
	Method types of network api
 */
typedef enum API_Method{
	API_NONE, /**< unknow api */
    API_LOG, /**< log*/
    API_CHECKUPDATE, /**< checkupdate*/
    API_OPENAPP,
    
    API_NEWUSER,
    API_RECOMMEND,
    API_RESTINFO,
    API_SEARCH
}API_Method;


/**
	Error code for request
 */
typedef enum API_STATUS_CODE{
	STATUS_SUCCESS = 0, /**< success */
	STATUS_UNKNOWN_ERROR = 1, /**< unknow error */
	STATUS_UNKNOWN_API = 2, /**< unkonw api */
	STATUS_INVALID_INPUT = 3, /**< invalid input */
	STATUS_NOT_LOGIN = 4, /**< user has not logined */
	STATUS_UNKNOWN_USER = 5, /**< unknow user */
	STATUS_PASSWORD_ERROR = 6, /**< wrong password */
	STATUS_NEWUSER_ERROR = 7, /**< error when create new user */
	STATUS_BIND_VERIFY_FAIL = 8, /**< verification failed when binding */
	STATUS_BIND_ERROR = 9, /**< bind error  */
	STATUS_SUCCESS_FIRST_BIND = 10, /**< succeed when binding for the first time */
	STATUS_ALREADY_BINDED = 11, /**< already binded */
	STATUS_UNBIND_ERROR = 12, /**< unbind error */
	STATUS_UPDATE_USERINFO_ERROR = 18, /**< error when updating user infor */
    STATUS_USER_NAME_EXSISTS = 20
} API_STATUS_CODE ;

@interface APIStatus : NSObject
@property (nonatomic,assign) API_STATUS_CODE statusCode;
@end


@interface RequestConf: NSObject
+ (void) configRequestSignatureMap;
@end