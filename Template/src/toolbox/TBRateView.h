//
//  TBFiveStarView.h
//  
//
//  Created by Yiming Lin on 11/29/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TBDoubleFaceView.h"

typedef enum DSFIVESTARCOLOR{
    FIVESTARCOLORORANGE,
    FIVESTARCOLORBLUE
}DSFIVESTARCOLOR;

@interface TBRateView : TTView
{
    @protected
    NSMutableArray* _starArray;
    CGFloat _rate;
}
-(id) initWithLeftImage:(NSString*) leftImage
             rightImage:(NSString *)rightImage;

//rate range:(0.0~5.0)
- (void) setRate:(CGFloat) rate;
- (CGFloat) getRate;
@end
