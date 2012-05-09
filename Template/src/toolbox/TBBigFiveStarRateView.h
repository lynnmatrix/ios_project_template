//
//  FiveStarRateView.h
//  
//
//  Created by Yiming Lin on 12/7/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TBRateView.h"


@interface TBBigFiveStarRateView : TBRateView
{
    DSFIVESTARCOLOR _colorType;
}
- (DSFIVESTARCOLOR) colorType;
- (void) setColorType:(DSFIVESTARCOLOR)colorType;
@end
