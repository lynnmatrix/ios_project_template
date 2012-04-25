//
//  User.h
//  
//
//  Created by Yiming Lin on 12/7/11.
//  Copyright (c) 2011 papa. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int64_t INVALIDUSERID;

/**
 error code of user name validation
 */
typedef enum USERNAME_VALIDITY_CODE{
	USERNAME_VALIDITY_CODE_VALID=0, /**< valid user name */
	USERNAME_VALIDITY_CODE_MIN, /**< too short name*/
	USERNAME_VALIDITY_CODE_MAX, /**< too long name */
	USERNAME_VALIDITY_CODE_INVALID_CHARACTER, /**< contain invalid character */
    USERNAME_VALIDITY_CODE_EXIST
}USERNAME_VALIDITY_CODE;



@interface User : NSObject

+ (NSString*) company;
+ (void) setCompany:(NSString*) company;

+ (void) setCookie:(NSHTTPCookie*) cookie;
+ (NSHTTPCookie*) cookie;

//+ (void) restoreCookie;

/**
 get user id
 @returns user id
 */
+ (int64_t ) getId;


/**
 set user id
 @param id user id
 */
+ (void) setId:(int64_t)id;



/**
 get user name
 @returns user name
 */
+ (NSString*) getName;


/**
 set user name
 @param name : user name
 */
+ (void) setName:(NSString*) name;


/**
 check whether user has logined
 @returns YES is user has logined, and vice versa ;
 */
+ (BOOL) isLogin;

/**
	check whether app has cookie stored locally
 */
+ (BOOL) hasCookie;


/**
 reset user info,set id to zero,and name to nil,file with user info will also be deleted
 */
+ (void) reset;

/**
 validate whether the given user name is valid
 @param name :user name to be validate
 @returns YES if valid,vice versa
 */
+ (USERNAME_VALIDITY_CODE) validateUserName: (NSString*) name;

@end
