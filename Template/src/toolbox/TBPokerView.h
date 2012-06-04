//
//  TBPokerView.h
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBPokerViewCell;

@protocol TBPokerViewDelegate,TBPokerViewDataSource;

@interface TBPokerView : UIScrollView
#pragma mark - Public Properties

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UIView *emptyView;
@property (nonatomic, retain) UIView *loadingView;

@property (nonatomic, assign, readonly) CGFloat colWidth;
@property (nonatomic, assign, readonly) NSInteger numCols;
@property (nonatomic, assign) NSInteger numColsLandscape;
@property (nonatomic, assign) NSInteger numColsPortrait;
@property (nonatomic, assign) id <TBPokerViewDelegate> pokerViewDelegate;
@property (nonatomic, assign) id <TBPokerViewDataSource> dataSource;

#pragma mark - Public Methods

/**
 Reloads the collection view
 This is similar to UITableView reloadData)
 */
- (void)reloadData;

/**
 Dequeues a reusable view that was previously initialized
 This is similar to UITableView dequeueReusableCellWithIdentifier
 */
- (UIView *)dequeueReusableView;

@end

