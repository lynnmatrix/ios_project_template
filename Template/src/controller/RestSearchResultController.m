//
//  RestSearchResultController.m
//  Fanfan
//
//  Created by Lin Yiming on 6/15/12.
//  Copyright (c) 2012 Lin Yiming. All rights reserved.
//

#import "RestSearchResultController.h"
#import "RestSearchDataSource.h"

@interface RestSearchResultController ()
@property (nonatomic, copy) NSString* key;
@end

@implementation RestSearchResultController
@synthesize key = _key;


- (id) initWithKey:(NSString*) key{
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.title = key;
        self.key = key;
    }
    return self;
}

- (void) createModel{
    self.dataSource = [[RestSearchDataSource alloc] initWithKey:self.key];
}

@end
