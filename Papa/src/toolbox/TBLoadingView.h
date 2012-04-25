//
//  TBLoadingView.h
//  
//
//  Created by Yiming Lin on 12/16/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//


@interface TBLoadingView : TTActivityLabel
{
    UIImageView *_animatedImage;
}

+ (void) showLoadingView:(BOOL) show;
@end
