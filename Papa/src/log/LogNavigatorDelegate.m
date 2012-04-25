//
//  LogNavigatorDelegate.m
//  
//
//  Created by Yiming Lin on 1/11/12.
//  Copyright (c) 2012 papa. All rights reserved.
//

#import "LogNavigatorDelegate.h"

#import "Logger.h"

@interface LogNavigatorDelegate () 
- (void) configLogMap;
- (void) addLogForURL: (NSString*)URL;
- (BOOL) hasClickPosInURL:(NSString*) URL;
- (int)  clickPosInURL:(NSString*) URL;
@end

@implementation LogNavigatorDelegate
@synthesize logSource = _logSource;

- (id) init
{
    if (self = [super init]) {
        
        _logMap = [[TTURLMap alloc] init];
        _logArray = [[NSMutableArray alloc] init];
        [self configLogMap];
    }
    return self;
}
#pragma mark -
#pragma mark TTNavigatorDelegate
- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
    return YES;
}

- (void)navigator:(TTBaseNavigator*)navigator willOpenURL:(NSURL*)URL
 inViewController:(UIViewController*)controller
{
    [self addLogForURL:URL.absoluteString];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addLogForURL: (NSString*)URL
{
    NSRange fragmentRange = [URL rangeOfString:@"#" options:NSBackwardsSearch];
    NSString* baseURL = URL;
    if (fragmentRange.location != NSNotFound) {
        baseURL =[URL substringToIndex:fragmentRange.location];
    }
    id object = [_logMap objectForURL:baseURL];
    if (object) {
        NSString* pageView = (NSString*) object;
        if ([pageView caseInsensitiveCompare:@"restaurantOverview"]==NSOrderedSame
            &&[self hasClickPosInURL:URL]) {
            int clickPos = [self clickPosInURL:URL];
            [[Logger defaultLogger] addLogWithPageView:pageView
                                              clickPos:clickPos];
        }else{
            [[Logger defaultLogger] addLogWithPageView:pageView];
        }
    }
}

// navigator map
- (void)configLogMap
{
    if (nil==self.logSource) {
        return;
    }
    NSDictionary* pageViewURLDict = [self.logSource pageViewURLDict];
    
    NSEnumerator* keyEnumerator = [pageViewURLDict keyEnumerator];
    NSString* pageView =nil;
    
    while (pageView=[keyEnumerator nextObject]) 
    {
        NSString* url = [pageViewURLDict objectForKey:pageView];
        LogPageView* logHelper = [[LogPageView alloc] initWithPageView:pageView];
        [_logArray addObject:logHelper];
        
        [_logMap from:url 
             toObject:logHelper
             selector:@selector(pageView)];
    } 
}

- (BOOL) hasClickPosInURL:(NSString*) URL
{
    NSRange fragmentRange = [URL rangeOfString:@"#" options:NSBackwardsSearch];
    if (fragmentRange.location != NSNotFound) {
        NSString* positionStr = [URL substringFromIndex:fragmentRange.location];
        if ([positionStr intValue]>=0) {
            return YES;
        }
    }
    return NO;
}

- (int) clickPosInURL:(NSString*) URL
{
    NSRange fragmentRange = [URL rangeOfString:@"#" options:NSBackwardsSearch];
    if (fragmentRange.location != NSNotFound) {
        NSString* positionStr = [URL substringFromIndex:fragmentRange.location];
        int clickPos = [positionStr intValue];
        if (clickPos>=0) {
            return clickPos;
        }
    }
    return -1;
}
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