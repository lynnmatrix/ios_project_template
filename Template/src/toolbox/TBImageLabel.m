//
//  TBImageLabel.m
//  
//
//  Created by Yiming Lin on 12/31/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TBImageLabel.h"
#import "DefaultCSSStyleSheet.h"
@implementation TBImageLabel

- (id) init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        _imageView= [[TTImageView alloc] init];
        [_imageView setAutoresizesToImage:YES];
        [self addSubview:_imageView];
        
        _label=[[UILabel alloc] init];
        _label.backgroundColor =[UIColor clearColor];
        _label.font = TTSTYLEVAR(font);
        _label.textColor = STYLEVAR(grayTextColor);
    
        _label.numberOfLines = 1;
        
        [self addSubview:_label];
    }
    return self;
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _label.center = _imageView.center;
    _label.left =_imageView.right+kTableCellSmallMargin;
}

- (CGSize) sizeThatFits:(CGSize)size
{
    [_label sizeToFit];
    CGFloat height = _imageView.height;
    CGFloat width = _imageView.width + _label.width+kTableCellSmallMargin;
    if (width>size.width&&size.width>0) {
        width = size.width;
    }
    return CGSizeMake(width, height);
}

- (void) setImageURL:(NSString*) imageURL
{
    _imageView.urlPath =imageURL;
}

- (void) setText: (NSString*) text
{
    _label.text = text;
}

//-(void) setFrame:(CGRect)frame{
//    [super setFrame:frame];
//    CGFloat width = frame.size.width;
//    CGFloat right = _label.right;
//    if (right>width) {
//        right = width;
//        _label.width = (right-_label.left);
//    }
//}

@end