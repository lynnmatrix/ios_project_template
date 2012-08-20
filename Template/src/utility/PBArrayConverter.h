//
//  PBArrayConverter.h
//  Discovery
//
//  Created by Yiming Lin on 12/16/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBArrayConverter : NSObject


/**
	convert pbarray to nsarray
    @param pbArray the PBArray instance to be converted 
	@returns NSArray instance
 */
+ (NSArray*) getNSArrayFromPBArray: (PBArray*) pbArray;


@end
