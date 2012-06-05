//
//  TBPokerViewNetworkEnabledDelegate.h
//  Template
//
//  Created by Lin Yiming on 6/5/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBPokerViewDelegate.h"

@class TTTableHeaderDragRefreshView, TTTableFooterInfiniteScrollView;
@protocol TTModel;


@interface TBPokerViewNetworkEnabledDelegate : TBPokerViewDelegate{
    id<TTModel>                      _model;
}
@property (nonatomic, retain) TTTableHeaderDragRefreshView* headerView;
@property (nonatomic, retain) TTTableFooterInfiniteScrollView* footerView;
@property (readonly) BOOL dragRefreshEnabled;
@property (readonly) BOOL infiniteScrollEnabled;

- (id)initWithController:(TBPokerViewController*)controller
         withDragRefresh:(BOOL)enableDragRefresh
      withInfiniteScroll:(BOOL)enableInfiniteScroll;
@end
