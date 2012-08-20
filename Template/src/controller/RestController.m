//
//  RestController.m
//  Template
//
//  Created by Lin Yiming on 8/20/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "RestController.h"
#import "RestDataSource.h"

@interface RestController ()
@property (nonatomic, readwrite) int64_t rid;
@end

@implementation RestController
@synthesize rid = _rid;

- (id) initWithRid:(int64_t) rid{
    if (self = [super init]) {
        self.rid = rid;
        self.variableHeightRows = YES;
    }
    return self;
}

- (void) createModel{
    self.dataSource = [[RestDataSource alloc] initWithRid:self.rid];
}
@end
