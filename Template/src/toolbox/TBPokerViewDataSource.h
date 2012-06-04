//
//  TBPokerViewDataSource.h
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TBPokerView;
@class TBPokerViewCell;

@protocol TBPokerViewDataSource <NSObject,TTModel>

@required
@property (nonatomic, retain) id<TTModel> model;
- (NSInteger)numberOfViewsInPokerView:(TBPokerView *)pokerView;
- (TBPokerViewCell *)pokerView:(TBPokerView *)pokerView viewAtIndex:(NSInteger)index;
- (CGFloat)heightForViewAtIndex:(NSInteger)index;
@end


@interface TBPokerViewDataSource : NSObject <TBPokerViewDataSource> {
    id<TTModel> _model;
}
@end