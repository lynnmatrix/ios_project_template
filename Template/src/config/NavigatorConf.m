//
//  NavigatorConf.m
//  
//
//  Created by Yiming Lin on 3/30/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import "NavigatorConf.h"
#import "UrlPageViewDefinition.h"
#import "Config.h"

#import "PPSquareViewController.h"
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
    
    [map            from:URL_Square
  toSharedViewController:[PPSquareViewController class]];
    
    [map            from:URL_Parties 
        toViewController:[PPPartyController class]];
    
    [map            from:URL_Friends
        toSharedViewController:[PPFriendController class]];
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
