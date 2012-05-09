//
//  TBAlertView.m
//  
//
//  Created by Yiming Lin on 12/16/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TBAlertView.h"

@implementation TBAlertView

- (id) initWithMessage:(NSString *)message
{
    if (self = [super init]) {
        self.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:10] next:
                      [TTSolidFillStyle styleWithColor:RGBACOLOR(0, 0, 0, 0.7) next:
                       nil]];
        self.backgroundColor = [UIColor clearColor];
        
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = TTSTYLEVAR(tableFont);
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = UITextAlignmentCenter;
        _label.numberOfLines=0;
        _label.text = message;
        [_label sizeToFit];
        
        [self addSubview:_label];

    }
    return self;
}

- (void) show{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    CGRect windowFrame = [window frameWithKeyboardSubtracted:0];
    self.centerX = windowFrame.size.width/2;
    self.centerY = windowFrame.size.height/2;
    
    [self removeFromSuperview];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    self.alpha = 0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    self.alpha= 1;
    [UIView commitAnimations];
}

- (void) showForAWhile
{
    [self show];
    
    [NSTimer scheduledTimerWithTimeInterval:2
                                      target:self
                                    selector:@selector(hide)
                                    userInfo:nil
                                     repeats:NO];
}

- (void) setMessage:(NSString*) message
{
    _label.text = message;
    _label.width = 300;
    [_label sizeToFit];
    _label.left = kTableCellMargin;
    _label.top = kTableCellMargin;
    self.width = _label.width + 2*kTableCellMargin;
    self.height = _label.height + 2*kTableCellMargin;
}

-(void) hide
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    self.alpha = 0;
    [UIView commitAnimations];
    [self removeFromSuperview];
}

@end

void DSAlert(NSString* message) 
{
    static TBAlertView* alert = nil;
    if (nil == alert) {
        alert = [[TBAlertView alloc] initWithMessage:message] ;
    }
    [alert setMessage:message];
    [alert showForAWhile];
}
