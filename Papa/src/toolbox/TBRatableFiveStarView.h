//
//  TBRatableFiveStarView1.h
//  
//
//  Created by Yiming Lin on 12/21/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "TBBigFiveStarRateView.h"
@protocol DSRateViewDelegate<NSObject>
@optional
- (void) onRateChanged:(TBRateView*) rateView;
- (void) onRateEnd:(TBRateView*) rateView;
@end

@interface TBRatableFiveStarView : TBBigFiveStarRateView <UIGestureRecognizerDelegate>{
    CGFloat _old_rate;
    DSFIVESTARCOLOR  _old_color;
}
@property (nonatomic, assign) id<DSRateViewDelegate> delegate;
@end
