//
//  Logger.h
//  
//
//  Created by Yiming Lin on 1/11/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestBatch;
@interface Logger : NSObject
{
    RequestBatch* _requestBatch;
    TTURLRequest* _request;
}
/**
 get default logger
 @returns default logger
 */
+ (Logger*) defaultLogger;

/**
	add log with page to view and position on search result list
	@param pageView page to view
	@param clickPos position on search result list
 */
- (void) addLogWithPageView:(NSString*)pageView
                 clickPos:(int)clickPos;

/**
	add log about page to view
	@param pageView page to view
 */
- (void) addLogWithPageView:(NSString*)pageView;


/**
	add log about device info
 */
- (void) addDeviceLog;

/**
	add crash report abount last crash
 */
- (void) addCrashReport:(NSString*) report;


/**
	send log to server
 */
- (void) sendLog;


@end
