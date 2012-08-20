//
//  PPSquareViewController.m
//  
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "RecommendController.h"

#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"

#import "PPSidebarDelegate.h"

#import "RecommendDataSource.h"

@interface RecommendController ()

@end

@implementation RecommendController
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSLocalizedString(@"正餐", nil);
    }
    return self;
}

#pragma mark Sidebar
- (void) viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                    target:self
                                                    action:@selector(revealLeftSidebar:)];
    
    self.navigationItem.revealSidebarDelegate = [PPSidebarDelegate sharedPPSidebarDelegate];
}

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

//////////////////////////////////////////////////////////////////////////////////
- (void) createModel{
    self.dataSource = [[RecommendDataSource alloc] init];
}

- (id<UITableViewDelegate>) createDelegate{
    return [[TTTableViewNetworkEnabledDelegate alloc] initWithController:self withDragRefresh:YES withInfiniteScroll:YES];
}
@end
