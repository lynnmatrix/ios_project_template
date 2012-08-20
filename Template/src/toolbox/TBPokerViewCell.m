//
//  TBPokerViewCell.m
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBPokerViewCell.h"

@implementation TBPokerViewCell

@synthesize object = _object;

@synthesize reuseIdentifier =_reuseIdentifier;

- (id) initWithReuseIdentifier:(NSString*)reuseIdentifier{
    if (self = [super init]) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (void)dealloc {
    self.object = nil;
    TT_RELEASE_SAFELY(_reuseIdentifier);
    [super dealloc];
}

- (void)prepareForReuse {
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    return 0.0;
}

@end
