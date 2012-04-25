//
//  TBTextButton.m
//  
//
//  Created by Yiming Lin on 2/8/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBTextButton.h"

#import "ImageUtility.h"

@implementation TBTextButton

- (id) init{
    if (self = [super init]) {
        self.contentMode =UIViewContentModeCenter;
        
        textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines =1;
        textLabel.font = TTSTYLEVAR(buttonFont);
        textLabel.textColor = TTSTYLEVAR(postButtonColor);
        textLabel.backgroundColor = [UIColor clearColor];
        
        backgroundImageView = [[UIImageView alloc] init];
        backgroundImageView.image = [[UIImage imageNamed:@"ButtonTransparent.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        backgroundImageView.highlightedImage=[[UIImage imageNamed:@"ButtonTransparentPressed"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];

        [self addSubview:backgroundImageView];
        [self addSubview:textLabel];
    }
    return self;
}

- (id) initWithTitle: (NSString*) title{
    if (self = [self init]) {
        textLabel.text =title;
    }
    return self;
}


-(void) layoutSubviews{
    [super layoutSubviews];
    
    //layout text label
    [textLabel sizeToFit];
    CGSize size = textLabel.size;
    if (size.width==0||size.height==0) {
        size = backgroundImageView.image.size;
    }else{
        size.width+=10;
        size.height+=10;
    }
    backgroundImageView.size =size;

    backgroundImageView.center = CGPointMake(self.width/2,self.height/2);

    switch (self.contentMode) {
        case UIViewContentModeRight:
        case UIViewContentModeTopRight:
        case UIViewContentModeBottomRight:
            backgroundImageView.right = self.width;
            break;
        case UIViewContentModeLeft:
        case UIViewContentModeBottomLeft:
        case UIViewContentModeTopLeft:
            backgroundImageView.left = 0;
            break;
        default:
            break;
    }
    
    switch (self.contentMode) {
        case UIViewContentModeTop:
        case UIViewContentModeTopLeft:
        case UIViewContentModeTopRight:
            backgroundImageView.top = 0;
            break;
        case UIViewContentModeBottom:
        case UIViewContentModeBottomLeft:
        case UIViewContentModeBottomRight:
            backgroundImageView.bottom = self.height;
            break;
        default:
            break;
    }
    textLabel.center = backgroundImageView.center;
}

- (void) setTitle:(NSString *)title
{
    textLabel.text = title;
    [self setNeedsDisplay];
}

- (void) setImage:(NSString *)imageURL forState:(UIControlState)state{
    UIImage* image = [[TTURLCache sharedCache] imageForURL:imageURL];
    image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:5];

    if (state == UIControlStateNormal) {
        [backgroundImageView setImage:image];
    }else {
        [backgroundImageView setHighlightedImage:image];
    }
    [self setNeedsDisplay];
}

-(void) setHighlighted:(BOOL)highlighted
{
    [backgroundImageView setHighlighted:highlighted];
    [super setHighlighted:highlighted];
}

-(void) setFont:(UIFont*) font{
textLabel.font = font;
[self setNeedsLayout];
}


@end
