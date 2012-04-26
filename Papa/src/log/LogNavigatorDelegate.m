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
- (void) addLogForURL: (NSString*)URL;
- (BOOL) hasClickPosInURL:(NSString*) URL;
- (int)  clickPosInURL:(NSString*) URL;
@end

@implementation LogNavigatorDelegate
@synthesize logSource = _logSource;

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
    
    NSString* pageView = [_logSource pageViewForURL:URL];
    if (pageView) {
        if ([self hasClickPosInURL:URL]) {
            int clickPos = [self clickPosInURL:URL];
            [[Logger defaultLogger] addLogWithPageView:pageView
                                              clickPos:clickPos];
        }else{
            [[Logger defaultLogger] addLogWithPageView:pageView];
        }
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