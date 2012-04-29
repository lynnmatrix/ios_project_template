//
//  PPSidebarDelegate.h
//  Papa
//
//  Created by Yiming Lin on 12-4-28.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTRevealSidebarV2Delegate.h"

@interface PPSidebarDelegate : NSObject <JTRevealSidebarV2Delegate>
+ (PPSidebarDelegate*) sharedPPSidebarDelegate;
@end
