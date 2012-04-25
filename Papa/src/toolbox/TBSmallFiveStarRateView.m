//
//  TBSmallFiveStarRateView.m
//  
//
//  Created by Yiming Lin on 12/7/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "TBSmallFiveStarRateView.h"

@implementation TBSmallFiveStarRateView
- (id)init
{
    self = [super initWithLeftImage:@"StarSmallOrange"
                         rightImage:@"StarSmallGray"];
    
    return self;
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
        leftImage =@"StarSmallOrange";
    }else{
        leftImage = @"StarSmallBlue";
    }
    for (int i =0; i<5; ++i) {
        TBDoubleFaceView* star = [_starArray objectAtIndex:i];
        [star setLeftImage:leftImage];
    }
    
}
@end
