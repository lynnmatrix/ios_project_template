//
//  TBPokerViewDataSource.m
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBPokerViewDataSource.h"
#import "TBPokerView.h"
#import "TBPokerViewCell.h"

@implementation TBPokerViewDataSource
@synthesize model =_model;

- (void) dealloc{

    [super dealloc];
}


- (NSInteger)numberOfViewsInPokerView:(TBPokerView *)pokerView{
    return 0;
}
- (TBPokerViewCell *)pokerView:(TBPokerView *)pokerView viewAtIndex:(NSInteger)index{
    return nil;
}
- (CGFloat)heightForViewAtIndex:(NSInteger)index{
    return 0;
}
@end
