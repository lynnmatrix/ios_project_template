//
//  User.m
//  
//
//  Created by Yiming Lin on 12/7/11.
//  Copyright (c) 2011 papa. All rights reserved.
//

#import "User.h"
#import "Utility.h"
#import "Config.h"

#import "Three20Core/TTDebugFlags.h"

int64_t INVALIDUSERID = 0;

/** 允许的最长字符字节(1个汉字代表2个字符)数  */
int USER_NAME_LENGTH_MAX = 30; 
    /** 允许的最短字符数  */
int USER_NAME_LENGTH_MIN = 4;

#define USER_ID          @"USER_ID"
#define USER_NAME        @"USER_NAME"
#define USER_COMPANY     @"USER_COMPANY"
#define USER_TRAFFICMODE @"USER_TRAFFICMODE"
#define USER_COOKIE      @"USER_COOKIE"

@implementation User

+ (NSUserDefaults*) userDefault{
    static NSUserDefaults* userDefault = nil;
    if (!userDefault) {
        userDefault = [[NSUserDefaults alloc] initWithUser:@"user of fanfan"];
    }
    return userDefault;
}

+ (int64_t ) getId
{
    int64_t userId = INVALIDUSERID;
    NSString* idStr = (NSString*)[[User userDefault] objectForKey:USER_ID];
    if (idStr) {
        userId = [idStr longLongValue];
    }
    TTDINFO(@"uid:%lld",userId);
    return userId;
}

+ (NSString*) getName
{
    return [[User userDefault] objectForKey:USER_NAME];
}

+ (void) setId:(int64_t)id
{
    [[User userDefault] setObject:[NSString stringWithFormat:@"%lld",id] 
                           forKey:USER_ID];
    [[User userDefault] synchronize];
}

+ (void) setName:(NSString*) name
{
    TTDASSERT(name);
    TTDASSERT(name.length>0);
    if (!name||[name isWhitespaceAndNewlines]) {
        return;
    }
    
    [[User userDefault] setObject:name forKey:USER_NAME];
    [[User userDefault] synchronize];
}

+ (NSString*) company{
    return [[User userDefault] objectForKey:USER_COMPANY];
}
+ (void) setCompany:(NSString*) company{
    if (!company) {
        return;
    }
    [[User userDefault] setObject:company forKey:USER_COMPANY];
    [[User userDefault] synchronize];
}


+ (BOOL) isLogin
{
    return ([User getName]!=nil&&[[User getName] length]>0);
}

+ (void) setCookie:(NSHTTPCookie *)cookie{
    if (!cookie) {
        [[User userDefault] removeObjectForKey:USER_COOKIE];
    }
    [[User userDefault] setObject:cookie.value 
                           forKey:USER_COOKIE];
    [[User userDefault] synchronize];
}

+ (NSHTTPCookie*) cookie{
    id value = [[User userDefault] objectForKey:USER_COOKIE];
    if (!value) {
        return nil;
    }
    NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             value,NSHTTPCookieValue,
                             @"/",NSHTTPCookiePath, 
                             cookieDomain,NSHTTPCookieDomain,
                             @"user",NSHTTPCookieName, nil]];
            TTDCONDITIONLOG(TTDFLAG_URLREQUEST,@"%@",cookie);
    return cookie;
}

+ (BOOL) hasCookie{
    if ([User cookie]) {
        return YES;
    }
    return NO;
}

+ (void)resetCookie{
    NSArray* cookieArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie* cookie in cookieArray) {
        if ([cookie.domain rangeOfString:cookieDomain].location!=NSNotFound) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    
    [User setCookie:nil];
}

+(void) reset
{
    [self resetCookie];
    
    if ([[User userDefault] objectForKey:USER_ID]) {
        [[User userDefault] removeObjectForKey:USER_ID];
    }
    if ([[User userDefault] objectForKey:USER_NAME]) {
        [[User userDefault] removeObjectForKey:USER_NAME];        
    }
    
    if ([[User userDefault] objectForKey:USER_COMPANY]) {
        [[User userDefault] removeObjectForKey:USER_COMPANY];
    }
 
    if ([[User userDefault] objectForKey:USER_TRAFFICMODE]) {
        [[User userDefault] removeObjectForKey:USER_TRAFFICMODE];
    }

}

+(NSRegularExpression*) getValidNameRegularExp
{
    /** 亚洲 **/
    static NSString* REGEX_ASIA = @"[\\u2E80-\\u9FFF\\uAC00-\\uD7A3]";
    /** 数字 **/
    static NSString* REGEX_DIGITAL = @"[0-9]";
    /** 英文 */
    static NSString* REGEX_ALPHA = @"[a-zA-Z]";
    /** 半角符号 */
    static NSString* REGEX_SYMBOL_HALF = @"[\\.\\-_~\\|]";
    /** 全角符号 */
    static NSString* REGEX_SYMBOL_FULL = @"[．－＿￣｜]";
    /** 所有满足条件的名字正则 */
    static NSString* REGEX_USER_NAME_ALL = nil;
    if (nil==REGEX_USER_NAME_ALL) {
        REGEX_USER_NAME_ALL = [NSString stringWithFormat:@"(%@|%@|%@|%@|%@)+",
                               REGEX_ASIA, 
                               REGEX_ALPHA,
                               REGEX_DIGITAL,
                               REGEX_SYMBOL_FULL,
                               REGEX_SYMBOL_HALF];
        TTDINFO(@"%@", REGEX_USER_NAME_ALL);
    }
    
    static NSRegularExpression* regularExpression = nil;
    if (nil == regularExpression) {
        regularExpression = [NSRegularExpression regularExpressionWithPattern:REGEX_USER_NAME_ALL
                                                                       options:0
                                                                         error:nil];
    }
    return regularExpression;
}

+ (USERNAME_VALIDITY_CODE) checkUserNameCharacter:(NSString*) userName
{

    NSRange userNameRange =NSMakeRange(0, userName.length);

    NSRegularExpression* validNameRegularExpression = [User getValidNameRegularExp];
    
    NSRange range = [validNameRegularExpression rangeOfFirstMatchInString:userName
                                                                  options:0
                                                                    range:userNameRange];

    if (!NSEqualRanges(range, userNameRange)) {
        TTDINFO(@"user name contain invalid character");
        return USERNAME_VALIDITY_CODE_INVALID_CHARACTER;
    }
    return USERNAME_VALIDITY_CODE_VALID;
}

+ (int) getSemanticLength:(NSString*) userName
{
    return [userName lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
}

+ (USERNAME_VALIDITY_CODE) checkUserNameLength:(NSString*) name
{    
    int len = [User getSemanticLength:name];
    if (len > USER_NAME_LENGTH_MAX) {
        return USERNAME_VALIDITY_CODE_MAX;
    } else if (len < USER_NAME_LENGTH_MIN) {
        return USERNAME_VALIDITY_CODE_MIN;
    }
    return USERNAME_VALIDITY_CODE_VALID;
}

+ (USERNAME_VALIDITY_CODE) validateUserName: (NSString *) userName  
{
    if (nil == userName||userName.length==0) {
        TTDINFO(@"nil user name");
        return USERNAME_VALIDITY_CODE_MIN;
    }

    USERNAME_VALIDITY_CODE code = [self checkUserNameLength:userName];
    if (USERNAME_VALIDITY_CODE_VALID!=code) {
        return code;
    }
    return [self checkUserNameCharacter:userName];
}


@end
