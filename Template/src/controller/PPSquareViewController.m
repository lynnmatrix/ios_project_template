//
//  PPSquareViewController.m
//  
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "PPSquareViewController.h"

#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"

#import "PPSidebarDelegate.h"

@interface PPSquareViewController ()

@end

@implementation PPSquareViewController
- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize  target:self action:@selector(revealLeftSidebar:)];
    
    self.navigationItem.revealSidebarDelegate = [PPSidebarDelegate sharedPPSidebarDelegate];
}

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}@end
