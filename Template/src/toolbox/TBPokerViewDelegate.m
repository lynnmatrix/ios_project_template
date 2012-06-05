//
//  TBPokerViewDelegate.m
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBPokerViewDelegate.h"
#import "TBPokerViewController.h"
#import "TBPokerViewDataSource.h"
#import "TBPokerView.h"
#import "TBPokerViewCell.h"


@implementation TBPokerViewDelegate
@synthesize controller = _controller;

- (id)initWithController:(TBPokerViewController*)controller{
    if (self = [super init]) {
        _controller = controller;
    }
    return self;
}
#pragma mark -
#pragma mark TBPokerViewDelegate

- (void)pokerView:(TBPokerView *)pokerView didSelectView:(TBPokerViewCell *)view atIndex:(NSInteger)index{
    id object = view.object;
    if ([object isKindOfClass:[TTTableLinkedItem class]]) {
        TTTableLinkedItem* item = object;
        if (item.URL && [_controller shouldOpenURL:item.URL]) {
            TTOpenURLFromView(item.URL, pokerView);
            
        } else if (item.delegate && item.selector) {
            [item.delegate performSelector:item.selector withObject:object];
        }
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    [TTURLRequestQueue mainQueue].suspended = YES;
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [TTURLRequestQueue mainQueue].suspended = NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (_controller.menuView) {
//        [_controller hideMenu:YES];
//    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [TTURLRequestQueue mainQueue].suspended = YES;
    
    [_controller didBeginDragging];
    
//    if ([scrollView isKindOfClass:[TBPokerView class]]) {
//        TBPokerView* pokerView = (TBPokerView*)scrollView;
//        pokerView.highlightedLabel.highlightedNode = nil;
//        pokerView.highlightedLabel = nil;
//    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [TTURLRequestQueue mainQueue].suspended = NO;
    }
    
    [_controller didEndDragging];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [TTURLRequestQueue mainQueue].suspended = NO;
}


@end
