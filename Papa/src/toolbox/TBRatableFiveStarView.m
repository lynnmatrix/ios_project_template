//
//  TBRatableFiveStarView1.m
//  
//
//  Created by Yiming Lin on 12/21/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "TBRatableFiveStarView.h"

@implementation TBRatableFiveStarView
@synthesize delegate = _delegate;

-(id) init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer* panGestureRecogdnizer 
        = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handlePanGesture:)];

        panGestureRecogdnizer.delegate =self;
        [self addGestureRecognizer:panGestureRecogdnizer];
        
        UITapGestureRecognizer* tapGestureRecognizer
        = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

#pragma mark -
#pragma mark private

- (BOOL) isRateLocationValid:(CGPoint)point
{
    if (point.y>=0&&point.y<=self.height&&point.x>=0) {
        return YES;
    }
    return NO;
}

- (int)getRateFromLocation:(CGPoint)gestureLocation
{
    int rate = gestureLocation.x/self.width*5+1;
    rate = MAX(0, rate);
    rate = MIN(5, rate);
    return rate;
}

- (void)updateRateWithLocation:(CGPoint)gestureLocation 
{
    int rate= [self getRateFromLocation:gestureLocation];
    
    [self setRate:rate];
    [self setColorType:FIVESTARCOLORORANGE];
}
- (BOOL) isScrolling:(UIGestureRecognizer*)sender
{
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]]
        &&sender.state == UIGestureRecognizerStateBegan) {
        CGPoint translation = [(UIPanGestureRecognizer*)sender translationInView:sender.view];
        if (fabs(translation.x)<fabs(translation.y)){
            return YES;
        }
    }
    return NO;
}

#pragma mark - 
#pragma mark handler of gestures
- (void)handlePanGesture:(UIPanGestureRecognizer *)sender 
{
    CGPoint gestureLocation = [sender locationInView:self];
    
    static BOOL canceled = NO;
    //begin
    if (sender.state == UIGestureRecognizerStateBegan) {
        //record origin data
        _old_rate = [self getRate];
        _old_color = [self colorType];
        
        //Scrolling in scrollview
        if ([self isScrolling:sender]) {
            [sender setCancelsTouchesInView:YES];
            canceled = YES;
            return;
        }else{
            canceled = NO;
        }
    }
    /**handlePanGesture: is called twice even if it's judged as scrolling 
     and cancelsTouchesInView is setted to YES,so static canceled is used*/
    if (canceled) {
        return;
    }
    
    //update rate
    [self updateRateWithLocation:gestureLocation];

    //Invalid region,recovery 
    if (![self isRateLocationValid:gestureLocation]) {
        [self setRate:_old_rate];
        [self setColorType:_old_color];
    }
    
    //end
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        if ([self isRateLocationValid:gestureLocation]) { //end of rate
            if (_delegate&&[_delegate conformsToProtocol:@protocol(DSRateViewDelegate) ]) {
                if ([self.delegate respondsToSelector:@selector(onRateEnd:)]) {
                    [self.delegate performSelector:@selector(onRateEnd:) withObject:self];
                }
            }
        }
    }else{
        if (_delegate&&[_delegate conformsToProtocol:@protocol(DSRateViewDelegate) ]) {
            if ([self.delegate respondsToSelector:@selector(onRateChanged:)]) {
                [self.delegate performSelector:@selector(onRateChanged:) withObject:self];                
            }

        }
    }
}


- (void)handleTapGesture:(UITapGestureRecognizer *)sender 
{
    CGPoint gestureLocation = [sender locationInView:self];;

    [self updateRateWithLocation:gestureLocation ];
    
    if (sender.state == UIGestureRecognizerStateEnded&&
        [self isRateLocationValid:gestureLocation])
    {   
        if (_delegate&&[_delegate conformsToProtocol:@protocol(DSRateViewDelegate) ]) {
            [self.delegate performSelector:@selector(onRateEnd:) withObject:self];
        }
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return [self isScrolling:gestureRecognizer];
}

@end
