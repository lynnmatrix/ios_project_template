//
//  ImageUtility.h
//  YouDaoCube
//
//  Created by He Yidong on 7/20/11.
//  Copyright 2011 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageUtility : NSObject {
    
}

+ (UIImage *) getSizedImage : (UIImage*) origImage
                     toSize : (CGSize) size;

+ (CGSize) fitSize : (CGSize) originSize 
             toFit : (CGSize) aSize;

+ (UIImage *) getSizedImage : (UIImage*) origImage
                toFill : (CGSize) newSize;

+ (CGSize) fitSize : (CGSize) originSize 
             toFit : (CGSize) aSize;


+ (unsigned char *) bitmapFromImage : (UIImage *) image;

+ (CGContextRef) newRGBBitmapContent : (CGSize) size;

+ (UIImage *) imageWithBits : (unsigned char *) bits 
                   withSize : (CGSize) size;

@end
