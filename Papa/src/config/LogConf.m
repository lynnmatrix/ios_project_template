//
//  LogConf.m
//  Papa
//
//  Created by Yiming Lin on 12-4-23.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "LogConf.h"

static  NSMutableDictionary* pvURLDict=nil;

@implementation LogConf
#pragma mark - 
#pragma mark LogSource
- (NSDictionary*) pageViewURLDict
{
    if (nil == pvURLDict) {
        pvURLDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                     URL_Main,PageView_Main,
                     nil];
    }
    return pvURLDict;
}

@end
