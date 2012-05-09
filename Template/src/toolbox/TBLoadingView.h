//
//  TBLoadingView.h
//  
//
//  Created by Yiming Lin on 12/16/11.
//  Copyright (c) 2011 . All rights reserved.
//

/**
 TBLoadingView will load images with name like Loading_%d.png 
 */
@interface TBLoadingView : TTActivityLabel
{
    UIImageView *_animatedImage;
}

+ (void) showLoadingView:(BOOL) show;
@end
