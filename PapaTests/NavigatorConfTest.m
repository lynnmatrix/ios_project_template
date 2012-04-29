//
//  NavigatorConfTest.m
//  Papa
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "NavigatorConfTest.h"
#import "NavigatorConf.h"
#import "Config.h"

@implementation NavigatorConfTest
- (void) testNavigatorConf{
    [NavigatorConf configNavigator];
    TTURLMap* urlMap = [[TTNavigator navigator] URLMap];
    id object =[urlMap objectForURL:@"dfsa"];
    STAssertTrue([object isKindOfClass:[TTWebController class]],nil);
}
@end
