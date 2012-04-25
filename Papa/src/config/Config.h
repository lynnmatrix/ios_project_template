#import <Foundation/Foundation.h>

extern NSString * rootURLPath;
extern NSString * urlPrefix;

extern NSString * server;
extern NSString * cookieDomain;
extern NSString * vendor;

extern const int DefaultResultsPerPage;
extern const int RestaurantNumberShouldBeRated;

extern const int RestCacheCapacity;

/**
	Default timeout of network request :10s
 */
extern const int DefaultRequestTimeOut;


extern NSString* softwareID;

extern NSString* clientId;
extern NSString* clientSecret;
extern NSString* redirectUri;
extern NSString* authorizeUrl;

extern const double Meters_Per_Mile;

#define DS_DEFAULT_CACHE_INVALIDATION_AGE (60*30) //unit:second

#define APP_VER ([NSString stringWithFormat : @"iphone_papa_%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]])