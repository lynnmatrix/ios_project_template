//
//  LogConf.m
//  
//
//  Created by Yiming Lin on 12-4-23.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "LogConf.h"
#import "LogDataSource.h"
#import "UrlPageViewDefinition.h"

@implementation LogConf

+ (void) prepareLogSource:(LogSource*) logSource{
    
    [logSource mapURL:IRI_Recommend toPageView:PageView_Recommend];
}

#pragma mark -
#pragma mark public
+ (void) confLogSource{
    TTNavigator* navigator = [TTNavigator navigator];

    LogNavigatorDelegate* logDelegate = [LogNavigatorDelegate sharedLogNavigatorDelegate];
    navigator.delegate = logDelegate;
    if (!logDelegate.logSource) {
        logDelegate.logSource = [[LogSource alloc] init];
        [self prepareLogSource:[logDelegate logSource]];
    }


}
@end
