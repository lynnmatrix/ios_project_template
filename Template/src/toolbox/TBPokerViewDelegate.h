//
//  TBPokerViewDelegate.h
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBPokerViewController.h"
#import "TBPokerView.h"


@protocol TBPokerViewDelegate <NSObject,UIScrollViewDelegate>

@optional
- (void)pokerView:(TBPokerView *)pokerView
    didSelectView:(TBPokerViewCell *)view
          atIndex:(NSInteger)index;

@end


@protocol TBPokerViewDelegate;

@interface TBPokerViewDelegate : NSObject <TBPokerViewDelegate,UIScrollViewDelegate>
- (id)initWithController:(TBPokerViewController*)controller;

@property (nonatomic, assign) TBPokerViewController* controller;
@end
