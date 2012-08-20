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

#import "RecommendController.h"
#import "RestController.h"
//#import "RestSearchResultController.h"

///////////////////////////////////

@implementation NavigatorConf

#pragma -
#pragma  navigator map
// navigator map
+ (void)prepareNavigatorMap:(TTURLMap *)map 
{
    [map            from:@"*" 
        toViewController:[TTWebController class]];
    
    [map            from:IRI_Recommend
  toSharedViewController:[RecommendController class]];
    
    [map            from:IRI_Rest
        toViewController:[RestController class]];
    
//    [map            from:IRI_Search
//        toViewController:[RestSearchResultController class]];
}



////////////////////////////////////////////////////////////////////////////////
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
