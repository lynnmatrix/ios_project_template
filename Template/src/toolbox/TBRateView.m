//
//  TBFiveStarView.m
//  
//
//  Created by Yiming Lin on 11/29/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TBRateView.h"

@implementation TBRateView


-(id) initWithLeftImage:(NSString*) leftImage
             rightImage:(NSString *)rightImage
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _starArray = [[NSMutableArray alloc] initWithCapacity:5] ;
        
        for (int i =0; i < 5; ++i) {
            TBDoubleFaceView* star = [[TBDoubleFaceView alloc] initWithLeftImage:leftImage
                                                  rightImage:rightImage];
            star.top = 0;
            star.left = (star.width*1.2) * i;
            
            [_starArray addObject:star];
            [self addSubview:star];
        }
        TBDoubleFaceView* lastStar = [_starArray objectAtIndex:4];
        self.frame = CGRectMake(0, 0, lastStar.right, lastStar.height); 
    }
    return self;
}

- (void) setRate:(CGFloat) rate
{
    if (rate<0||rate>5) {
        return;
    }

    _rate = rate;
    
    for (int i =0; i<5; ++i) {
        TBDoubleFaceView* star = [_starArray objectAtIndex:i];
        if (rate > 0.999) {
            [star setRatio:1.0];
        }else 
        {
            [star setRatio:MAX(0, rate)];
        }
        rate -= 1.0;
    }
}

- (CGFloat) getRate
{
    return _rate;
}

@end
