//
//  LogConfTests.m
//  Papa
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "LogConfTests.h"
#import "LogConf.h"
#import "LogNavigatorDelegate.h"

@implementation LogConfTests
- (void) testLogConf{
    [LogConf confLogSource];
    LogSource* logSource = [(LogNavigatorDelegate*)[[TTNavigator navigator] 
                                                        delegate] logSource]; 
    STAssertNotNil(logSource,nil);
}
@end
