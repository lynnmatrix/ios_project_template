//
//  UIViewController+DSCatolog.m
//  Discovery
//
//  Created by Yiming Lin on 11/25/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TTViewControllerDSCatolog.h"

#import "Three20UI/UINavigationControllerAdditions.h"

#import "Three20UICommon/UIViewControllerAdditions.h"

#import "TBLoadingView.h"
#import "LogNavigatorDelegate.h"

TT_FIX_CATEGORY_BUG(TTViewControllerDSCatolog)

extern int NavigationBackgroundTag;

@implementation TTViewController (DSCategory)

- (void)configLeftBarButton:(UIViewController *)controller
{
    TTButton *backButton = [TTButton buttonWithStyle:@"buttonBackForState:" 
                                               title:NSLocalizedString(@"  返回", 
                                                                       nil)];
    backButton.font = TTSTYLEVAR(tableSmallFont);
    [backButton addTarget:self 
                   action:@selector(removeFromSupercontroller) 
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 55, 30);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [controller.navigationItem setLeftBarButtonItem:backBarButtonItem 
                                           animated:NO];
}

- (void)resetPositionOfBackgoundView
{
    UINavigationBar* navigationBar = self.navigationController.navigationBar;
    for (UIView* view in navigationBar.subviews) {
        if (view.tag == NavigationBackgroundTag) {
            [view removeFromSuperview];
            [navigationBar insertSubview:view
                                 atIndex:0];
        }
    }
}

- (void)addSubcontroller:(UIViewController*)controller animated:(BOOL)animated
              transition:(UIViewAnimationTransition)transition {
        
    if (self.navigationController) {
        [self.navigationController addSubcontroller:controller animated:animated
                                         transition:transition];
    }
    [self configLeftBarButton:controller];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [TTURLRequestQueue mainQueue].suspended = NO;
    [self resetPositionOfBackgoundView];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TBLoadingView showLoadingView:NO];
}

- (void) setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20.0];
//        titleView.shadowColor = [UIColor whiteColor];
        
        titleView.textColor = RGBCOLOR(61,56,55); // Change to desired color
        
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeFromSupercontrollerAnimated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:animated];
    }
    [[LogNavigatorDelegate sharedLogNavigatorDelegate] addLogForURL:[[TTNavigator navigator] URL]];
}
@end
