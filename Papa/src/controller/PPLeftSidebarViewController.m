//
//  PPLeftSidebarViewController.m
//  Papa
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "PPLeftSidebarViewController.h"
#import "PPLeftSidebarTableViewDelegate.h"
#import "UrlPageViewDefinition.h"

@interface PPLeftSidebarViewController ()

@end

@implementation PPLeftSidebarViewController

- (void)createModel{
    self.dataSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:NSLocalizedString(@"趴趴", nil) URL:URL_Square],
                       [TTTableTextItem itemWithText:NSLocalizedString(@"趴友", nil) URL:URL_Friends],nil];
}

- (id<UITableViewDelegate>)createDelegate {
    return [[PPLeftSidebarTableViewDelegate alloc] init];
}
@end
