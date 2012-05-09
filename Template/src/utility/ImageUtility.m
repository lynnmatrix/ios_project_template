//
//  ImageUtility.m
//
//  Created by He Yidong on 7/20/11.
//  Copyright 2011 . All rights reserved.
//

#import "ImageUtility.h"


@implementation ImageUtility

+ (CGSize) fitSize : (CGSize) originSize 
             toFit : (CGSize) aSize
{
    CGFloat scale;
    CGSize newSize = originSize;
    if (newSize.height && newSize.height > aSize.height)
    {
        scale = aSize.height / newSize.height;
        newSize.width *= scale;
        newSize.height *= scale;
    }
    
    if (newSize.width && newSize.width > aSize.width)
    {
        scale = aSize.width / newSize.width;
        newSize.width *= scale;
        newSize.height *= scale;
    }
    return newSize;
}

+ (UIImage *) getSizedImage : (UIImage*) origImage
                     toSize : (CGSize) size
{
    CGSize origSize = origImage.size;
    CGSize newSize = [ImageUtility fitSize : origSize toFit : size];
    
    UIGraphicsBeginImageContext(newSize);
    
    CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
    [origImage drawInRect : rect];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImg;
}

+ (UIImage *) getSizedImage : (UIImage*) origImage
                     toFill : (CGSize) newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
    [origImage drawInRect : rect];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImg;
}

+ (unsigned char *) bitmapFromImage : (UIImage *) image
{
    CGContextRef context = [ImageUtility newRGBBitmapContent : image.size];
    if (context == nil)
        return nil;
    CGRect rect =  CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    unsigned char *data = CGBitmapContextGetData(context);
	CGContextRelease(context);
    return data;
}

+ (CGContextRef) newRGBBitmapContent : (CGSize) size //  返回值必须主动释放
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == nil)
        return nil;
    
    void *bitmapData = malloc(size.width * size.height * 4);
    if (bitmapData == nil)
    {
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    
    CGContextRef context = CGBitmapContextCreate(bitmapData, size.width, size.height, 8, size.width * 4, 
                                                 colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGColorSpaceRelease(colorSpace);
    if (context == nil)
    {
        free(bitmapData);
        return nil;
    }
    else
        return context;
}

+ (UIImage *) imageWithBits: (unsigned char *) bits withSize: (CGSize) size
{
	// Create a color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
    {
        return nil;
    }
	
    CGContextRef context = CGBitmapContextCreate (bits, size.width, size.height, 8, size.width * 4, 
                                                  colorSpace, kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
		CGColorSpaceRelease(colorSpace );
		return nil;
    }
	
    CGColorSpaceRelease(colorSpace);
	CGImageRef ref = CGBitmapContextCreateImage(context);
	//free(CGBitmapContextGetData(context));
	CGContextRelease(context);
	
	UIImage *img = [UIImage imageWithCGImage:ref];
	CFRelease(ref);
	return img;
}


@end
