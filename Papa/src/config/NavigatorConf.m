//
//  NavigatorConf.m
//  
//
//  Created by Yiming Lin on 3/30/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "NavigatorConf.h"
#import "UrlPageViewDefinition.h"
#import "Config.h"

#import "PPTabBarController.h"
#import "PPPartyController.h"
#import "PPFriendController.h"
///////////////////////////////////

@implementation NavigatorConf

#pragma -
#pragma  navigator map
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

+ (void)configNavigator
{
    TTNavigator* navigator = [TTNavigator navigator];
    
    navigator.persistenceMode = TTNavigatorPersistenceModeNone;
    
    // URLMap
    TTURLMap* map = [navigator URLMap];
    
    [self prepareNavigatorMap:map];
    
    [self prepareGeneralMap:map];
}

@end
