//
//  TBFiveStarRateView.m
//  
//
//  Created by Yiming Lin on 12/7/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "TBBigFiveStarRateView.h"

@implementation TBBigFiveStarRateView
- (id)init
{
    self = [super initWithLeftImage:@"StarBigOrange"
                         rightImage:@"StarBigGray"];
    if (self) {
        _colorType = FIVESTARCOLORORANGE;
    }
    return self;
}

- (DSFIVESTARCOLOR) colorType
{
    return _colorType;
}

- (void) setColorType:(DSFIVESTARCOLOR)colorType
{
    TTDASSERT(colorType==FIVESTARCOLORBLUE||colorType==FIVESTARCOLORORANGE);
    if (_colorType == colorType) {
        return;
    }
    _colorType = colorType;
    
    NSString* leftImage=nil;
    if (FIVESTARCOLORORANGE==colorType) {
        leftImage =@"StarBigOrange";
    }else{
        leftImage = @"StarBigBlue";
    }
    for (int i =0; i<5; ++i) {
        TBDoubleFaceView* star = [_starArray objectAtIndex:i];
        [star setLeftImage:leftImage];
    }
    
}
@end
