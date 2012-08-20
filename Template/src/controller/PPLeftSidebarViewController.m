//
//  PPLeftSidebarViewController.m
//  
//
//  Created by Yiming Lin on 12-4-29.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "PPLeftSidebarViewController.h"
#import "LeftSidebarTableViewDelegate.h"
#import "UrlPageViewDefinition.h"

@interface PPLeftSidebarViewController ()

@end

@implementation PPLeftSidebarViewController

- (void)createModel{
    self.dataSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:NSLocalizedString(@"推荐", nil) URL:IRI_Recommend],
                       /**[TTTableTextItem itemWithText:NSLocalizedString(@"搜索", nil)
                        URL:[NSString stringWithFormat:@"iri://search?key=%@",[@"苏浙汇" urlEncoded]]],**/
                       nil];
}

- (id<UITableViewDelegate>)createDelegate {
    return [[LeftSidebarTableViewDelegate alloc] initWithController:self];
}
@end
