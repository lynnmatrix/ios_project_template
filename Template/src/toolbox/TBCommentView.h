//
//  TBCommentView.h
//  
//
//  Created by Yiming Lin on 12/26/11.
//  Copyright (c) 2011 . All rights reserved.
//

/**
	text view with boundary checker
 */
@interface TBCommentView : TTView <UITextViewDelegate>{
@private
    UIImageView* _backgroundImageView;
    UITextView* _commentTextView;
    UILabel* _letterCountLabel;
    //user has interactive with textView if YES
    BOOL _inited;
    int _maxTextLength ;
}


/**
	text 
 */
- (void)setText:(NSString*) text;
- (NSString*)text;



/**
 set the upper bound of text length
 */
- (void) setMaxTextLength: (int) maxTextLength;
@end