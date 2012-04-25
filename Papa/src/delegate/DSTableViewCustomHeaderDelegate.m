//
//  DSTableViewCustomHeaderDelegate.m
//  
//
//  Created by Yiming Lin on 12/19/11.
//  Copyright (c) 2011 papa. All rights reserved.
//

#import "DSTableViewCustomHeaderDelegate.h"

@implementation DSTableViewCustomHeaderDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString* title = [tableView.dataSource tableView:tableView
                              titleForHeaderInSection:section];
    if (title!=nil&&title.length>0) {
        return 37;
    }
    return [super tableView:tableView
   heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [super tableView:tableView
                    viewForHeaderInSection:section];
    if (headerView) {
        headerView.frame =CGRectMake(0.0, 0.0, 320.0, 36.5);
        headerView.backgroundColor = [UIColor clearColor];
        UIImageView* bkImageView = [[UIImageView alloc] initWithImage:
                                     [[UIImage imageNamed:@"SectionHeader"]
                                      stretchableImageWithLeftCapWidth:15 
                                      topCapHeight:15]] ;
        
        bkImageView.size = headerView.size;
        [headerView insertSubview:bkImageView
                          atIndex:0];
    }

    return headerView;
}

@end
