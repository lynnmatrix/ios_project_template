//
//  TBPokerViewDelegate.h
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBPokerView, TBPokerViewCell;
@class TBPokerViewController;

@protocol TBPokerViewDelegate <NSObject,UIScrollViewDelegate>

@optional
- (void)pokerView:(TBPokerView *)pokerView
    didSelectView:(TBPokerViewCell *)view
          atIndex:(NSInteger)index;

@end


@interface TBPokerViewDelegate : NSObject <TBPokerViewDelegate>{
    TBPokerViewController* _controller;
}

- (id)initWithController:(TBPokerViewController*)controller;

@property (nonatomic, assign) TBPokerViewController* controller;
@end
