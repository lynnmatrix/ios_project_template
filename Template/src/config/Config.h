#import <Foundation/Foundation.h>

extern NSString * rootURLPath;
extern NSString * urlPrefix;

extern NSString * server;
extern NSString * cookieDomain;
extern NSString * vendor;

extern const int DefaultResultsPerPage;
/**
	Default timeout of network request :10s
 */
extern const int DefaultRequestTimeOut;


extern NSString* softwareID;

/** 有道饭饭申请新浪应用时对应的AppKey */
extern NSString* clientId;
/** 有道饭饭申请新浪应用时对应的AppSecret */
extern NSString* clientSecret;
/** 授权后的回调地址 */
extern NSString* redirectUri;
extern NSString* authorizeUrl;

extern const double Meters_Per_Mile;

#define DS_DEFAULT_CACHE_INVALIDATION_AGE (60*30) //unit:second

#define APP_VER ([NSString stringWithFormat : @"iphone_%@%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]])