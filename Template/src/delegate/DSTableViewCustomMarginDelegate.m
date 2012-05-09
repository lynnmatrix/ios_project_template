//
//  DSTableViewCustomMarginDelegate.m
//  
//
//  Created by Yiming Lin on 12/19/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "DSTableViewCustomMarginDelegate.h"

@implementation DSTableViewCustomMarginDelegate
- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kTableCellSmallMargin)];
}
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kTableCellSmallMargin)];
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kTableCellSmallMargin;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kTableCellSmallMargin;
}
@end
