//
//  TBAlertView.h
//  
//
//  Created by Yiming Lin on 12/16/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

@interface TBAlertView : TTView
{
    UILabel * _label;
}
- (id) initWithMessage:(NSString *)message;

- (void) showForAWhile;

/** 
 show the alert view
 */
- (void) show;

/**
	hidden the alert view
 */
- (void) hide;


/** 
 set the message showed in alert view
 @param message 
 */
- (void) setMessage:(NSString*) message;
@end

void DSAlert(NSString* message);