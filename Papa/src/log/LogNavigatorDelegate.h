//
//  LogNavigatorDelegate.h
//  
//
//  Created by Yiming Lin on 1/11/12.
//  Copyright (c) 2012 papa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogDataSource.h"

@interface LogNavigatorDelegate : NSObject <TTNavigatorDelegate>

/**
	Source for log,which provides dictionary with pageview as key 
    and url of view controller as object
 */
@property (nonatomic, strong) id<LogSource> logSource;


/**
	add log for url 
 */
- (void)addLogForURL: (NSString*)URL;

@end

