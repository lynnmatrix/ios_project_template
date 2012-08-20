//
//  PBArrayConverter.m
//  Discovery
//
//  Created by Yiming Lin on 12/16/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "PBArrayConverter.h"

@implementation PBArrayConverter

+ (NSArray*) getNSArrayFromPBArray: (PBArray*) pbArray
{
    int count = pbArray.count;
    NSMutableArray* nsArray= [NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; ++i) {
        [nsArray addObject:[pbArray objectAtIndex:i]];
    }
    return nsArray;
}
@end
