//
//  PPSidebarDelegate.m
//  Papa
//
//  Created by Yiming Lin on 12-4-28.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "PPSidebarDelegate.h"
#import "PPLeftSidebarViewController.h"

#import "Utility.h"

@implementation PPSidebarDelegate

SINGLETON_GCD(PPSidebarDelegate);

#pragma mark JTRevealSidebarDelegate

- (UIView *)viewForLeftSidebar {

    CGRect viewFrame = TTRectInset(TTScreenBounds(), UIEdgeInsetsMake(TTStatusHeight(), 0, 0, 0)); 

    static PPLeftSidebarViewController *sidebarController = nil;
    if ( ! sidebarController) {
        sidebarController = [[PPLeftSidebarViewController alloc] init];;
    }
    sidebarController.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    sidebarController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return sidebarController.view;
}


@end
