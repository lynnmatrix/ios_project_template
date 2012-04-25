//
//  DiscoveryDefaultCSSStyleSheet.h
//  Discovery
//
//  Created by Yiming Lin on 11/1/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//
#import "extThree20CSSStyle/TTDefaultCSSStyleSheet.h"


#define DSSTYLESHEET ((DiscoveryDefaultCSSStyleSheet*)[TTStyleSheet globalStyleSheet])

#define DSSTYLEVAR(_VARNAME) [DSSTYLESHEET _VARNAME]

@interface DiscoveryDefaultCSSStyleSheet : TTDefaultCSSStyleSheet
@property (nonatomic, readonly) UIImage* navigationBarImage;
@property (nonatomic, readonly) UIColor* tableCellBackgroundColor;
@property (nonatomic, readonly) UIColor* accountConfigBkColor;
@property (nonatomic, readonly) UIColor* grayTextColor;
@property (nonatomic, readonly) UIColor* hintTextColor;
@property (nonatomic, readonly) UIColor* orangeTextColor;
@end
