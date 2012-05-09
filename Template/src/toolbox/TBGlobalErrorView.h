//
//  TBGlobalErrorView.h
//  
//
//  Created by Yiming Lin on 12/15/11.
//  Copyright (c) 2011 . All rights reserved.
//

@interface TBGlobalErrorView : TTView
{
    TTImageView* _imageView;
    UILabel* _messageLabel;
    
    UIWindow* _window;
    NSTimer* _timer;
}

/**
	Network connection error
 */
+ (void) showNetworkErrorView;

/**
	Empty response list
 */
+ (void) showEmptyErrorView;

/**
	Other error about network request,such as error occurs when parsing response
 */
+ (void) showRequestFailureView;


/**
	show error view with given message and image url
 */
+ (void) showErrorViewWithMessage:(NSString*) message
                         imageURL:(NSString*) imageURL;


@end
