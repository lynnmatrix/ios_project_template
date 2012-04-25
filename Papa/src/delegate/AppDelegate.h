//
//  DCAppDelegate.h
//  
//
//  Created by Yiming Lin on 10/26/11.
//  Copyright (c) 2011 papa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class URLRequestModel;
@class LogNavigatorDelegate;

extern const int NavigationBackgroundTag ;

@interface AppDelegate : NSObject <UIApplicationDelegate,UIAlertViewDelegate,TTNavigatorDelegate>
{

}


- (void)configNavigationBarStyle;
@end
