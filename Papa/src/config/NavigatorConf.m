//
//  NavigatorConf.m
//  
//
//  Created by Yiming Lin on 3/30/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "NavigatorConf.h"
#import "LogNavigatorDelegate.h"
#import "LogConf.h"
#import "Config.h"

#import "PPTabBarController.h"
#import "PPPartyController.h"
#import "PPFriendController.h"
///////////////////////////////////

@implementation NavigatorConf
#pragma -
#pragma  navigator map
// navigator map without parameter
+ (void)prepareGeneralMap:(TTURLMap *)map 
{
    [map from:[urlPrefix stringByAppendingString:@"nib/(loadFromNib:)"] 
toSharedViewController:self];
    
    [map from:[urlPrefix stringByAppendingString:@"nib/(loadFromNib:)/(withClass:)"]
toSharedViewController:self];
    
    [map from:[urlPrefix stringByAppendingString:@"viewController/(loadFromVC:)"] 
toSharedViewController:self];
    
    [map from:[urlPrefix stringByAppendingString:@"modal/(loadFromNib:)" ]
toModalViewController:self];
}

// navigator map
+ (void)prepareNavigatorMap:(TTURLMap *)map 
{
    [map            from:@"*" 
        toViewController:[TTWebController class]];
    
    [map            from:URL_Main 
  toSharedViewController:[PPTabBarController class]];
    
    [map            from:@"pp://party" 
        toViewController:[PPPartyController class]];
    
    [map            from:@"pp://friend"
        toViewController:[PPFriendController class]];
}

+ (LogNavigatorDelegate*) getNavigatorDelegate{
    static LogNavigatorDelegate* delegate;
    if (nil==delegate) {
        delegate = [[LogNavigatorDelegate alloc] init];
        delegate.logSource = [[LogConf alloc] init];
    }
    return delegate;
}

+ (void)prepareNavigator
{
    TTNavigator* navigator = [TTNavigator navigator];
    
    navigator.persistenceMode = TTNavigatorPersistenceModeNone;
    
    navigator.delegate = [self getNavigatorDelegate];
    
    // URLMap
    TTURLMap* map = [navigator URLMap];
    
    [self prepareNavigatorMap:map];
    
    [self prepareGeneralMap:map];
}

@end
