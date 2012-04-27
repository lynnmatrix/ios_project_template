//
//  LogDataSource.m
//  Papa
//
//  Created by Yiming Lin on 12-4-26.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import "LogDataSource.h"

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

@implementation LogPageView
@synthesize pageView = _pageView;

- (id) initWithPageView:(NSString*)pageView
{
    if (self = [super init]) {
        self.pageView = pageView;
    }
    return self;
}

+ (LogPageView*) loggerHelperWithPageView: (NSString*) pageView
{
    LogPageView* result = [[LogPageView alloc] initWithPageView:pageView];
    return result;
}
@end

static LogSource* logSource = nil;

@implementation LogSource

- (id) init{
    if (self = [super init]) {
        _urlPageViewMap = [[TTURLMap alloc] init];
        _pageViewArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (LogSource*) globalLogSource{
    if (nil == logSource) {
        logSource = [[LogSource alloc] init];
    }
    return logSource;
//    __block LogSource* logSource = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        logSource = [[LogSource alloc] init];
//    });
//    return logSource;
}

- (void) mapURL:(NSString*) url toPageView:(NSString*) pageView{
    
    LogPageView* logHelper = [[LogPageView alloc] initWithPageView:pageView];
    [_pageViewArray addObject:logHelper];
    
    [_urlPageViewMap from:url 
                 toObject:logHelper
                 selector:@selector(pageView)];
}

- (void) removeMapForURL:(NSString*) url{
    [_pageViewArray removeObject:url];
    [_urlPageViewMap removeURL:url];
}

#pragma mark -
#pragma mark protocol LogDataSource
- (NSString*) pageViewForURL:(NSString *)url{
    return  [_urlPageViewMap objectForURL:url];
}
@end

