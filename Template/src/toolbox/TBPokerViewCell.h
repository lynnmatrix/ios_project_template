//
//  TBPokerViewCell.h
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBPokerViewCell : UIView
@property (nonatomic, retain) id object;
@property (nonatomic, copy) NSString* reuseIdentifier;
 
- (id) initWithReuseIdentifier:(NSString*)reuseIdentifier;

- (void)prepareForReuse;

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth;

@end
