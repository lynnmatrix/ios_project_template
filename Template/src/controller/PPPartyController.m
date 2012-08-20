//
//  PPPartyController.m
//  
//
//  Created by mac on 12-4-21.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "PPPartyController.h"

#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"

#import "PPSidebarDelegate.h"

@interface PPPartyController ()

@end

@implementation PPPartyController

- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                    target:self
                                                    action:@selector(toggleSidebar:)];
    
    self.navigationItem.revealSidebarDelegate = [PPSidebarDelegate sharedPPSidebarDelegate];

}

- (void)toggleSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

@end
