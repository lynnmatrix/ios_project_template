//
//  TBImageButton.m
//  
//
//  Created by Yiming Lin on 12/30/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "TBImageButton.h"


@implementation TBImageButton
- (id) init
{
    if (self = [self initWithImageURL:nil]) {
        
    }
    return self; 
}

- (id) initWithImageURL:(NSString*)imageURL
{
    if (self = [super init]) {
        
        [self setStylesWithSelector:@"buttonRightForState:"];
        
        _leftImageView = [[TTImageView alloc] init];
        _leftImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        _leftImageView.left = kTableCellHPadding;
        if (imageURL!=nil&&![imageURL isWhitespaceAndNewlines]) {
            _leftImageView.urlPath = imageURL;
        }else{
            _leftImageView.urlPath = @"bundle://StarBigBlue.png";
        }
        
        _leftImageView.autoresizesToImage = YES;
        [self addSubview:_leftImageView];
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _leftImageView.top = (self.height-_leftImageView.height)/2;
}

@end