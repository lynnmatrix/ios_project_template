//
//  PPSidebarDelegate.h
//  
//
//  Created by Yiming Lin on 12-4-28.
//  Copyright (c) 2012年 . All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTRevealSidebarV2Delegate.h"

@interface PPSidebarDelegate : NSObject <JTRevealSidebarV2Delegate>
+ (PPSidebarDelegate*) sharedPPSidebarDelegate;
@end
