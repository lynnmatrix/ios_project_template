//
//  TimeUtility.m
//  
//
//  Created by Yiming Lin on 12/20/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TimeUtility.h"

@implementation TimeUtility

//EventTime 以1970为起点，单位为毫秒；本SDK的绝对时间以2001为起点,且单位为秒
+ (double) getEventTimeSince2001: (int64_t) eventTime
{
    TTDASSERT(eventTime>0);
    return eventTime/1000.0 - kCFAbsoluteTimeIntervalSince1970;
}

+ (NSString*) textOfTime: (CFAbsoluteTime) time since: (CFAbsoluteTime) since {
    double diff = time - since;
    if (diff < 60.0)
        return @"现在";
	if (diff  < 60.0 * 60.0 )
		return [@"" stringByAppendingFormat:@"%i分钟前", (int)(diff / 60.0)];
	if (diff  < 24.0 * 60.0 * 60.0 )
		return [@"" stringByAppendingFormat:@"%i小时前", (int)(diff / (60.0 * 60.0))];
	if (diff  < 30.0 * 24.0 * 60.0 * 60.0)
		return [@"" stringByAppendingFormat:@"%i天前", (int)(diff / (24.0 * 60.0 * 60.0))];
	return [@"" stringByAppendingFormat:@"%i月前", (int)(diff / (30.0 * 24.0 * 60.0 * 60.0))];
}

+ (int64_t)getThisYearTimeSince2001
{
    CFTimeZoneRef zoneRef = CFTimeZoneCopySystem();
    CFGregorianDate thisYear = 
    CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(),
                                   zoneRef);
    thisYear.month = 1;
    thisYear.day = 1;
    thisYear.hour = 0;
    thisYear.minute = 0;
    thisYear.second = 0;
    
    int64_t startTimeOfThisYearSince2001 = (int64_t)CFGregorianDateGetAbsoluteTime(thisYear, 
                                                                                   zoneRef);
    CFRelease(zoneRef);
    return startTimeOfThisYearSince2001;
}

+ (int64_t)getTodayTimeSince2001
{
    int64_t currentTime = CFAbsoluteTimeGetCurrent();
    currentTime /= (24 * 60 * 60);
    currentTime *= (24 * 60 * 60);
    return currentTime;
}

+ (int64_t)getYesterdayTimeSince2001
{
    return [TimeUtility getTodayTimeSince2001] - 24.0 * 60.0 * 60.0;
}

+ (NSString*) getTimeIntervalDescriptionSinceEventTime:(int64_t) eventTime
{
    int64_t currentTimeSince2001 = CFAbsoluteTimeGetCurrent();
    int64_t absoluteEventTime = [self getEventTimeSince2001:eventTime];

    //eventTime = -1
    if (eventTime<=0) {
        absoluteEventTime = currentTimeSince2001;
    }
    return [TimeUtility textOfTime:currentTimeSince2001
                             since:absoluteEventTime];
}

+ (NSString*) getEventTimeAsString : (int64_t) eventTime
{
    int64_t thisYearTimeSince2001 = [TimeUtility getThisYearTimeSince2001];
    int64_t todayTimeSince2001 = [TimeUtility getTodayTimeSince2001];    
    int64_t yeaterdayTimeSince2001 = [TimeUtility getYesterdayTimeSince2001];
    
    CFTimeZoneRef zoneRef = CFTimeZoneCopySystem();
    int64_t eventTimeSince2001 =[self getEventTimeSince2001:eventTime];
    if (eventTime<0) {
        CFRelease(zoneRef);
        return nil;
    }
    CFGregorianDate date = CFAbsoluteTimeGetGregorianDate(eventTimeSince2001,
                                                          zoneRef);
    
    CFRelease(zoneRef);
    NSString* strDate = nil;
    if (eventTimeSince2001 >= todayTimeSince2001)
    {
        strDate = [[NSString alloc] 
                   initWithFormat : @"今天 %02i:%02i", date.hour, date.minute];
    }
    else if (eventTimeSince2001 >= yeaterdayTimeSince2001)
    {
        strDate = [[NSString alloc] 
                   initWithFormat : @"昨天 %02i:%02i", date.hour, date.minute];
    }
    else if (eventTimeSince2001 >= thisYearTimeSince2001)
    {
        strDate = [[NSString alloc] 
                   initWithFormat : @"%02i-%02i %02i:%02i", 
                   date.month, date.day,
                   date.hour, date.minute];
    }
    else
    {
        strDate = [[NSString alloc] 
                   initWithFormat : @"%04i-%02i-%02i %02i:%02i", 
                   date.year, date.month, date.day,
                   date.hour, date.minute];
    }
    
    return strDate;
}

@end
