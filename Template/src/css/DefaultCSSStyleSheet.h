//
//  DefaultCSSStyleSheet.h
//  
//
//  Created by Yiming Lin on 11/1/11.
//  Copyright (c) 2011 . All rights reserved.
//
#import "extThree20CSSStyle/TTDefaultCSSStyleSheet.h"


#define STYLESHEET ((DefaultCSSStyleSheet*)[TTStyleSheet globalStyleSheet])

#define STYLEVAR(_VARNAME) [STYLESHEET _VARNAME]

@interface DefaultCSSStyleSheet : TTDefaultCSSStyleSheet
@property (nonatomic, readonly) UIImage* navigationBarImage;
@property (nonatomic, readonly) UIColor* tableCellBackgroundColor;
@property (nonatomic, readonly) UIColor* accountConfigBkColor;
@property (nonatomic, readonly) UIColor* grayTextColor;
@property (nonatomic, readonly) UIColor* hintTextColor;
@property (nonatomic, readonly) UIColor* orangeTextColor;
@property (nonatomic, readonly) UIColor* pokerViewBackgroundColor;
@end
