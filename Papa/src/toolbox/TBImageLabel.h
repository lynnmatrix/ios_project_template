//
//  TBImageLabel.h
//  
//
//  Created by Yiming Lin on 12/31/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//


/**
	view with image left and label right
 */
@interface TBImageLabel : TTView{
@private
    TTImageView* _imageView;
    UILabel* _label;
}

/**
	set image for image view on the left side
	@param imageURL :url of image like "bundle://a.png" or "http://a.png"
 */
-(void)setImageURL:(NSString*)imageURL;

/**
	set text to be showed on right label
 */
- (void) setText: (NSString*) text;

@end