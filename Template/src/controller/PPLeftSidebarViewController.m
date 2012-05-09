//
//  PPLeftSidebarViewController.m
//  
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "PPLeftSidebarViewController.h"
#import "PPLeftSidebarTableViewDelegate.h"
#import "UrlPageViewDefinition.h"

@interface PPLeftSidebarViewController ()

@end

@implementation PPLeftSidebarViewController

- (void)createModel{
    self.dataSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:NSLocalizedString(@"menu1", nil) URL:URL_Square],
                       [TTTableTextItem itemWithText:NSLocalizedString(@"menu2", nil) URL:URL_Friends],nil];
}

- (id<UITableViewDelegate>)createDelegate {
    return [[PPLeftSidebarTableViewDelegate alloc] init];
}
@end
