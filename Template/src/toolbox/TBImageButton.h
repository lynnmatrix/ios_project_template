//
//  TBImageButton.h
//  
//
//  Created by Yiming Lin on 12/30/11.
//  Copyright (c) 2011 . All rights reserved.
//

/**
	Button with customed image on the left side 
 */
@interface TBImageButton : TTButton{
@private
    TTImageView* _leftImageView;
}

/**
	new DSImageButton with given image URL
	@param imageURL :url of image
	@returns new instance of DSImageButton
 */
- (id) initWithImageURL:(NSString*)imageURL;

@end
