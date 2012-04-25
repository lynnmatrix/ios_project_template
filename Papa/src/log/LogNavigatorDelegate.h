//
//  LogNavigatorDelegate.h
//  
//
//  Created by Yiming Lin on 1/11/12.
//  Copyright (c) 2012 papa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LogSource <NSObject>

/**
 provides dictionary with pageview as key 
 and url of view controller as object
 */
- (NSDictionary*) pageViewURLDict;

@end

@interface LogNavigatorDelegate : NSObject <TTNavigatorDelegate>
{
    TTURLMap* _logMap;
    NSMutableArray* _logArray;
}

/**
	Source for log,which provides dictionary with pageview as key 
    and url of view controller as object
 */
@property (nonatomic, strong) id<LogSource> logSource;


/**
	add log for url 
 */
- (void)addLogForURL: (NSString*)URL;

@end


@interface LogPageView : NSObject{
    NSString* _pageView;
}
@property (nonatomic, retain) NSString* pageView;

/**
 initialize DSLogHelper with page view
 @param pageView page to view
 */
- (id) initWithPageView:(NSString*)pageView;

/**
 create initialize DSLogHelper with page view
 @param page view
 @returns instance of DSLoggerHelper
 */
+ (LogPageView*) loggerHelperWithPageView: (NSString*) pageView;

@end
