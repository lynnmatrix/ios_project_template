//
//  LogDataSource.h
//  Papa
//
//  Created by Yiming Lin on 12-4-26.
//  Copyright (c) 2012年 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LogSource <NSObject>

/**
 return the pageview log for given url which usually stands for specific page(ViewController)
 */
- (NSString*) pageViewForURL:(NSString*) url;


@end

@interface LogSource : NSObject<LogSource>
{
    TTURLMap* _urlPageViewMap;
    NSMutableArray* _pageViewArray;
}

+ (LogSource*) globalLogSource;
- (void) mapURL:(NSString*) url toPageView:(NSString*) pageView;
- (void) removeMapForURL:(NSString*) url;
@end
