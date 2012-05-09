//
//  TimeUtility.h
//  
//
//  Created by Yiming Lin on 12/20/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtility : NSObject
/*
 Returns the text description of a specified time relative to another time (since)
 */
+ (NSString *)textOfTime: (CFAbsoluteTime) time since: (CFAbsoluteTime) since;

//获得时间

/**
 get the description of time interval between given eventTime and current time
 @param eventTime: event time since 1970
 @returns description like "2分钟前"，"1小时前"，"1天前" "1月前"
 @description EventTime 以1970为起点，单位为毫秒；本SDK的绝对时间以2001为起点,且单位为秒
 */
+ (NSString*) getTimeIntervalDescriptionSinceEventTime:(int64_t) eventTime;

/**
 get the description of event time
 @param eventTime: event time since 1970
 @returns description with format like "2012-01-01 00:00" 
 */
+ (NSString*) getEventTimeAsString : (int64_t) eventTime;

@end
