//
//  PPTabBarController.m
//  Papa
//
//  Created by Yiming Lin on 12-4-21.
//  Copyright (c) 2012年. All rights reserved.
//

#import "PPTabBarController.h"
#import <Three20/Three20.h>
@interface PPTabBarController ()

@end

@implementation PPTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabURLs:[NSArray arrayWithObjects:@"pp://party",
                      @"pp://friend",
                      nil]];

}


@end
