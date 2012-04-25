//
//  TBDoubleFaceView.m
//  
//
//  Created by Yiming Lin on 11/29/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "TBDoubleFaceView.h"

@implementation TBDoubleFaceView

- (id) initWithLeftImage:(NSString*) leftImageName
              rightImage:(NSString*) rightImageName
{
    if (self = [super init]) {
        self.backgroundColor =[UIColor clearColor];
        
        _leftImageView = [[UIImageView alloc] init];
        _rightImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
        [self addSubview:_rightImageView];
        
        _leftImageView.contentMode = UIViewContentModeTopLeft;
        _rightImageView.contentMode = UIViewContentModeTopRight;
        [_leftImageView setClipsToBounds:YES];
        [_rightImageView setClipsToBounds:YES];
        
        UIImage* leftImage = [UIImage imageNamed:leftImageName];
        UIImage* rightImage = [UIImage imageNamed:rightImageName];
        _leftImageView.image = leftImage;
        _rightImageView.image = rightImage;
        CGFloat height = leftImage.size.height > rightImage.size.height?leftImage.size.height:rightImage.size.height;
        CGFloat width = leftImage.size.width > rightImage.size.width?leftImage.size.width:rightImage.size.width;
        
        [self setFrame:CGRectMake(0, 0, width, height)];
        [self setRatio:0];
    }
    return self;
}

- (id) initWithUpImage:(NSString*) upImage
             downImage:(NSString*) downImage
{
    if (self = [self initWithLeftImage:downImage
                     rightImage:upImage]) {
        _vertical = YES;
        _leftImageView.contentMode = UIViewContentModeBottomLeft;
        _rightImageView.contentMode = UIViewContentModeTopLeft;
    }
    return self;
}


- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_vertical) {
        _leftImageView.left=0;
        _leftImageView.bottom=frame.size.width;
        _leftImageView.height=frame.size.height;
        
        _rightImageView.top = 0;
        _rightImageView.right =frame.size.width;
        _rightImageView.height = frame.size.height;
    }else{
        _leftImageView.left=0;
        _leftImageView.top=0;
        _leftImageView.height=frame.size.height;
        
        _rightImageView.top = 0;
        _rightImageView.right =frame.size.width;
        _rightImageView.height = frame.size.height;
    }

}

- (void)setRatio: (CGFloat) ratio
{
    _ratio = ratio;
    if (_vertical) {
        _leftImageView.height = ratio*self.height;
        _leftImageView.bottom = self.height;
        _rightImageView.height = self.height- _leftImageView.height;
        _rightImageView.top = 0;
    }else{
        _leftImageView.width = ratio*self.width;
        _leftImageView.left = 0;
        _rightImageView.width = self.width - _leftImageView.width;
        _rightImageView.right = self.width;
    }
}

- (CGFloat) getRatio
{
    return _ratio;
}

- (void) setLeftImage:(NSString*) leftImage
{
    UIImage* image=[UIImage imageNamed:leftImage];
    _leftImageView.image = image;
}
@end
