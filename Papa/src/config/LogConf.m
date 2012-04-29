//
//  LogConf.m
//  Papa
//
//  Created by Yiming Lin on 12-4-23.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "LogConf.h"
#import "LogDataSource.h"
#import "UrlPageViewDefinition.h"

@implementation LogConf

+ (void) prepareLogSource:(LogSource*) logSource{
    
    [logSource mapURL:URL_Square toPageView:PageView_Square];
}

+ (LogNavigatorDelegate*) getNavigatorDelegate{
    static LogNavigatorDelegate* delegate;
    if (nil==delegate) {
        delegate = [[LogNavigatorDelegate alloc] init];
        delegate.logSource = [[LogSource alloc] init];
        [self prepareLogSource:delegate.logSource];
    }
    return delegate;
}

#pragma mark - 
#pragma mark public
+ (void) confLogSource{
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.delegate = [self getNavigatorDelegate];
}
@end
