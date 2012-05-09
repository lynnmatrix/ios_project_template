//
//  Utility.m
//
//  Created by zheng on 10-7-15.
//  Copyright 2010 . All rights reserved.
//

#import "Utility.h"
#import "Config.h"
#import <CommonCrypto/CommonDigest.h>


#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation Utility


+ (int) getTheDigitsOfNumber:(int)number
{
    if (number<1) {
        return 0;
    }
    else if (number<10)
        return 1;
    else if (number<100)
        return 2;
    else {
        return 3;
    }
    
}

+ (NSString *)getDocumentPath
{
	static NSString * documentPath = nil;
	if( documentPath!=nil )
		return documentPath;
    
	NSArray * paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
    documentPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
	return documentPath;
}

+ (NSString *)getCachePath
{
	static NSString * cachePath = nil;
	if( cachePath!=nil )
		return cachePath;
    
	NSArray * paths = NSSearchPathForDirectoriesInDomains
	(NSCachesDirectory, NSUserDomainMask, YES);
    cachePath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
	return cachePath;
}

+ (NSString *)getFilePathInCache:(NSString *)fileName
{
	NSString * cachePath = [self getCachePath];
	return [cachePath stringByAppendingPathComponent:fileName];
}

+ (NSString *)getFilePathInDocument:(NSString *)fileName
{
	NSString * documentPath = [self getDocumentPath];
    
	return [documentPath stringByAppendingPathComponent:fileName];
}

+ (NSString*) escapeURL: (NSString*) url {
    NSString* res= [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return res;
}


+ (NSString *)escapeXML:(NSString *)xml
{
	if( xml==nil ) return @"";
	
	NSString * str = [NSString stringWithString:xml];
	
	//convert & into &amp;
	//should be done first
	str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
	
	//convert < into &lt;
	str = [str stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
	
	//convert > into &gt; 
	str = [str stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
	
	//convert ' into &apos
	str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
	
	//convert " into &quot;
	str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
	
	return str;
}

+ (UIImage*) scaleImage: (UIImage*) photo
                 toSize: (CGSize) newSize 
{
	//scale the image
	UIGraphicsBeginImageContext(newSize);
	[photo drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage * newPhoto = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newPhoto;
}

+ (NSString*) prefixOfString: (NSString*) string
				   forLength: (int) length
{
	if (string == nil) {
        return nil;
    } // if
    const int orgLen = [string length];
	int l = 0,  i = 0;
	for (; i < orgLen && l < length; i ++) {
		unichar c = [string characterAtIndex: i];
		if (c < 128) {
			l ++;
		} else {
			l += 2;
		} // else
	} // for i
    
	return [string substringToIndex: i];
}


+ (BOOL) isPhoneNum : (NSString *) phoneNum
{
	if( nil == phoneNum||[phoneNum length]!=11 )
	{
		return NO;
	}
	
	for(int i=0; i<[phoneNum length]; ++i)
	{
		if( [phoneNum characterAtIndex:i]<'0' 
		   || [phoneNum characterAtIndex:i]>'9' )
		{
			
			return NO;
		}
	}
	
	return YES;
}

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
+ (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *) uniqueGlobalDeviceIdentifier{
    NSString *macaddress = [Utility macaddress];
    NSString *uniqueIdentifier = [macaddress md5Hash];
    
    return uniqueIdentifier;
}

+ (NSString *) getSuffixOfUrl
{
    static NSString *suffixWithoutLastDelay = nil;
    if (suffixWithoutLastDelay == nil)
	{
		suffixWithoutLastDelay = [[NSString alloc] initWithFormat:@"&ver=%@&imei=%@&vendor=%@", 
                                  APP_VER, 
                                  [Utility uniqueGlobalDeviceIdentifier],
                                  vendor
                                  ];
	}

    return suffixWithoutLastDelay;
}  
@end
