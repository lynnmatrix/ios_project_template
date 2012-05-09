//
//  TBDoubleFaceView.h
//  
//
//  Created by Yiming Lin on 11/29/11.
//  Copyright (c) 2011 . All rights reserved.
//


/**
	Combined image view with two images
 */
@interface TBDoubleFaceView : TTView
{
    UIImageView* _leftImageView;
    UIImageView* _rightImageView;
    CGFloat _ratio;
    BOOL _vertical;
}

/**
 Initialize a new DSDoubleFaceView object in the horizontal orientaiton
 @param leftImage image showed on the left
 @param rightImage image showed on the right
 @returns new DSDoubleFaceView
 */
- (id) initWithLeftImage:(NSString*) leftimage
              rightImage:(NSString*) rightImage;


/**
	Initialize a new DSDoubleFaceView object in the vertical orientaiton
	@param upImage image showed above
	@param downImage image showed below
	@returns new DSDoubleFaceView
 */
- (id) initWithUpImage:(NSString*)upImage
              downImage:(NSString*)downImage;



/**
 set the ratio of left or down image
 @param ratio :range:(0.0~1.0)
 */
- (void)setRatio: (CGFloat) ratio;


/**
	return ratio of left or down image
	@returns ratio
 */
- (CGFloat) getRatio;


/**
	set customed image to be showed on the left side
 */
- (void) setLeftImage:(NSString*) leftImage;

@end
