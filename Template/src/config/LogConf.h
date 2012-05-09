//
//  LogConf.h
//  
//
//  Created by Yiming Lin on 12-4-23.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "LogNavigatorDelegate.h"

@class LogSource;

@interface LogConf : NSObject
/**
	configure the map from url to pageview,which is used for log
 */
+ (void) confLogSource;

@end
