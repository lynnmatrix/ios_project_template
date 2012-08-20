//
//  TBLoadingView.m
//  
//
//  Created by Yiming Lin on 12/16/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TBLoadingView.h"


@implementation TBLoadingView
-(id) init
{
    if (self =[super initWithStyle:TTActivityLabelStyleBlackBezel]) {
        self.text = NSLocalizedString(@"请稍候...", nil);
        _animatedImage = [[UIImageView alloc] init];
        NSMutableArray *imageArray = [NSMutableArray array];
        int i;
        for (i = 1; i <= 100; i++)
        {
            NSString* imageName = [NSString stringWithFormat:@"Loading_%d", i];
           NSString* imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            if (!imagePath) {
                break;
            }
            UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
            [imageArray addObject:image];
        }
        [_animatedImage setBackgroundColor:[UIColor clearColor]];
        [_animatedImage setAnimationImages:imageArray];
        [_animatedImage setAnimationDuration:1.0];
        [_bezelView addSubview:_animatedImage];
        [_animatedImage startAnimating];
        _label.font = TTSTYLEVAR(font);
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [_activityIndicator setHidden:YES];
    [_bezelView setFrame:CGRectMake(0, 0, 110, 100)];
    _bezelView.centerX = self.width/2;
    _bezelView.centerY = self.height/2;
    [_animatedImage setFrame:CGRectMake(0,0, 59, 60)];
    _animatedImage.centerX = _bezelView.width/2;
    _animatedImage.top = kTableCellVPadding;
    _label.top = _animatedImage.bottom +kTableCellVPadding;
    _label.centerX = _bezelView.width/2;
}

+ (void) showLoadingView:(BOOL) show
{
    static TBLoadingView* loadingView = nil;
    if (nil == loadingView) {
        loadingView = [[TBLoadingView alloc] init];
    }
    
    if (show) {
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        
        CGRect windowFrame = [window frameWithKeyboardSubtracted:0];
        loadingView.centerX = windowFrame.size.width/2;
        loadingView.centerY = windowFrame.size.height/2;
        
        if (window!=loadingView.superview) {
            [loadingView removeFromSuperview];
            [window addSubview:loadingView];
        }

        [window bringSubviewToFront:loadingView];
        if (loadingView.alpha == 1) {
            return;
        }
        loadingView.alpha = 0;
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        loadingView.alpha= 1;
        [UIView commitAnimations];

    }else{
        CGContextRef context= UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        loadingView.alpha = 0;
        [UIView commitAnimations];
    }
}

@end
