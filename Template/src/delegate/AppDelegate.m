
//
//  AppDelegate.m
//
//  Created by Yiming Lin on 10/26/11.
//  Copyright (c) 2011. All rights reserved.
//

#import "AppDelegate.h"

#import "NavigatorConf.h"
#import "LogConf.h"
#import "RequestConf.h"

#import "User.h"

//CSS
#import "DefaultCSSStyleSheet.h"

//Configuration
#import "Config.h"

#import "Utility.h"

////////////////////For development/////////
//log
#import "Logger.h"

//crash report
#import <CrashReporter/CrashReporter.h>

////////////////////END of For development/////////

const int NavigationBackgroundTag = 15769457;

@interface AppDelegate ()
@property (nonatomic, strong) LogNavigatorDelegate* navigatorDelegate;  
@end

@implementation AppDelegate

@synthesize navigatorDelegate = _navigatorDelegate;

#pragma -
#pragma  load viewcontroller
/**
 * Loads the given viewcontroller from the nib
 */
- (UIViewController*)loadFromNib:(NSString *)nibName withClass:className {
    UIViewController* newController = [[NSClassFromString(className) alloc]
                                       initWithNibName:nibName bundle:nil];
    
    return newController;
}

/**
 * Loads the given viewcontroller from the the nib with the same name as the
 * class
 */
- (UIViewController*)loadFromNib:(NSString*)className {
    return [self loadFromNib:className withClass:className];
}

/**
 * Loads the given viewcontroller by name
 */
- (UIViewController *)loadFromVC:(NSString *)className {
    UIViewController * newController = [[ NSClassFromString(className) alloc] init];
    
    return newController;
}

- (void)configNavigationBarStyle
{
    UIImage *image = (UIImage*) TTSTYLEVAR(navigationBarImage);
    
    UINavigationBar* navigationBar
    = TTNavigator.navigator.visibleViewController.navigationController.navigationBar;

    if([ navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    } 
    else{
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        imgView.tag = NavigationBackgroundTag;
        [imgView setUserInteractionEnabled:NO];
        [navigationBar insertSubview:imgView atIndex:0];
    }
}

- (void) sendDeviceInfoLog
{
    [[Logger defaultLogger] addDeviceLog];
}

- (void)prepareCSSStyle {
    DefaultCSSStyleSheet *styleSheet = [[DefaultCSSStyleSheet alloc] init];
    
    [TTStyleSheet setGlobalStyleSheet:styleSheet];
}

#pragma mark -
#pragma mark crash report

- (void) sendCrashReport:(PLCrashReport* )report{
    
    /* Threads */
    NSMutableString* stackStr = [[NSMutableString alloc] init];

    for (PLCrashReportThreadInfo *thread in report.threads) {
        if (!thread.crashed) {
            continue;
        } 
        [stackStr appendFormat: @"Thread %ld Crashed:\n", (long) thread.threadNumber];
        for (NSUInteger frame_idx = 0; frame_idx < [thread.stackFrames count]; frame_idx++) {
            PLCrashReportStackFrameInfo *frameInfo = [thread.stackFrames objectAtIndex: frame_idx];
            PLCrashReportBinaryImageInfo *imageInfo;
            
            /* Base image address containing instrumention pointer, offset of the IP from that base
             * address, and the associated image name */
            uint64_t baseAddress = 0x0;
            uint64_t pcOffset = 0x0;
            NSString *imageName = @"\?\?\?";
            
            imageInfo = [report imageForAddress: frameInfo.instructionPointer];
            if (imageInfo != nil) {
                imageName = [imageInfo.imageName lastPathComponent];
                baseAddress = imageInfo.imageBaseAddress;
                pcOffset = frameInfo.instructionPointer - imageInfo.imageBaseAddress;
            }
            
            [stackStr appendFormat: @"%-4ld%-36s0x%08" PRIx64 " 0x%" PRIx64 " + %" PRId64 "\n", 
             (long) frame_idx, [imageName UTF8String], frameInfo.instructionPointer, baseAddress, pcOffset];
        }
    }
    
    NSMutableString* crashes = [NSMutableString string];
    
    [crashes appendFormat:@"\n<crash>\n \
     product_name       :%@\n \
     bundleidentifier   :%@\n \
     system_version     :%@\n \
     platform           :%@\n \
     application_version:%@\n \
     device_locale      :%@\n \
     exception_name     :%@\n \
     signal_name        :%@\n \
     signal_code        :%@\n \
     signal_address     :%llx\n ",
     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"],
     report.applicationInfo.applicationIdentifier,
     report.systemInfo.operatingSystemVersion,
     TTDeviceModelName(),
     report.applicationInfo.applicationVersion,
     [[NSLocale currentLocale] localeIdentifier],
     report.exceptionInfo.exceptionName,
     report.signalInfo.name,
     report.signalInfo.code,
     report.signalInfo.address];
    [crashes appendString:stackStr];
    [crashes appendString:@"</crash>"];
    
    [[Logger defaultLogger] addCrashReport:crashes];
    NSLog(@"%@",crashes);
}

//
// Called to handle a pending crash report.
//
- (void) handleCrashReport {
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    NSData *crashData;
    NSError *error;
    
    // Try loading the crash report
    crashData = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
    if (crashData == nil) {
        NSLog(@"Could not load crash report: %@", error);
    }else{
        
        PLCrashReport *report = [[PLCrashReport alloc] initWithData: crashData error: &error];
        if (report == nil) {
            NSLog(@"Could not parse crash report");
        }else {
            [self sendCrashReport:report];
            NSLog(@"Crashed on %@", report.systemInfo.timestamp);
            NSLog(@"Crashed with signal %@ (code %@, address=0x%" PRIx64 ")", report.signalInfo.name,
                  report.signalInfo.code, report.signalInfo.address);  
        }
    }
    
    // Purge the report
    [crashReporter purgePendingCrashReport];
    return;
}

- (void)enableAndHandleCrashReport {
    //crash report
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    NSError *error;
    
    // Check if we previously crashed
    if ([crashReporter hasPendingCrashReport])
        [self handleCrashReport];
    
    // Enable the Crash Reporter
    if (![crashReporter enableCrashReporterAndReturnError: &error])
        NSLog(@"Warning: Could not enable crash reporter: %@", error);
}

- (void) restoreCookie{
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    // Load the saved cookies
    NSHTTPCookie* cookie = [User cookie];
    if (cookie) {
        [cookieStorage setCookie:cookie];
    }
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    [application setStatusBarStyle : UIStatusBarStyleBlackTranslucent];
    
    /**
    	Should be called before configNavigationBarStyle,since it will be used in the later one
     */
    [self prepareCSSStyle];

    [NavigatorConf configNavigator];
    [LogConf confLogSource];
    [RequestConf configRequestSignatureMap];
    
    [TTURLRequestQueue mainQueue].defaultTimeout = DefaultRequestTimeOut;
    [self restoreCookie];
    
    if (INVALIDUSERID!=[User getId]&&[User hasCookie]) {
        if (![[TTNavigator navigator] restoreViewControllers]) {
            [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:rootURLPath]];
        }
    }else{
        [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:@"iri://square"]];
    }
    /**
    	Should be called after open view controller in navigator
     */
    [self configNavigationBarStyle];
    
    [NSTimer scheduledTimerWithTimeInterval:5
                            target:self
                          selector:@selector(sendDeviceInfoLog)
                          userInfo:nil
                           repeats:NO];

    [self enableAndHandleCrashReport];

}



@end
