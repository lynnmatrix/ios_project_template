//
//  PPLeftSidebarDelegate.m
//  Papa
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "PPLeftSidebarTableViewDelegate.h"
#import "UIViewController+JTRevealSidebarV2.h"

@implementation PPLeftSidebarTableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController* currentVC = [[TTNavigator navigator] visibleViewController];
    currentVC.view.userInteractionEnabled = YES;
    [currentVC.navigationController setRevealedState:JTRevealedStateNo];
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}
@end
