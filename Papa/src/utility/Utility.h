//
//  Utility.h
//  YouDaoCube
//
//  Created by zheng on 10-7-15.
//  Copyright 2010 youdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>


//一些实用函数的集合
@interface Utility : NSObject
{
	
}

//
+ (int) getTheDigitsOfNumber:(int)number;

//获得当前的document目录
+ (NSString *)getDocumentPath;
//获得filename文件的路径
+ (NSString *)getFilePathInDocument:(NSString *)fileName;

+ (NSString *)getCachePath;
+ (NSString *)getFilePathInCache:(NSString *)fileName;

// 转码url，把 url 中需要做参数的各种字符转为 %xx 的格式
+ (NSString *)escapeURL:(NSString *)url;

//转码xml
+ (NSString *)escapeXML:(NSString *)xml;

//缩放uiimage
+ (UIImage *)scaleImage:(UIImage *)photo
				 toSize:(CGSize)newSize;

//获得字符串string的前 length 个字符，汉字算两个
+ (NSString *)prefixOfString:(NSString *)string
				   forLength:(int)length;

+ (BOOL) isPhoneNum : (NSString *) phoneNum;


/**
	mac address of this device
 */
+ (NSString *) macaddress;

/*
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */

+ (NSString *) uniqueGlobalDeviceIdentifier;

/**
	@returns suffix of url request which is like @"&ver=0.1.0&imei=387497979fafaf&vendor=appstore"
 */
+ (NSString *) getSuffixOfUrl;


/*!
 * @function Singleton GCD Macro
 */
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}                                                           
#endif

@end
