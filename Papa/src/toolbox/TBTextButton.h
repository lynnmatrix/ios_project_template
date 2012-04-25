//
//  TBTextButton.h
//  
//
//  Created by Yiming Lin on 2/8/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//


/**
	Button with title and transparent background,
 background image's just surround title label,
 so button's response area(button's frame) can be larger than background image
 and it has the ability to adjust the position of content
 */
@interface TBTextButton : TTButton
{
    UILabel* textLabel;
    UIImageView* backgroundImageView;
}

- (id) initWithTitle: (NSString*) title;

- (void) setTitle:(NSString*) title;

@end
