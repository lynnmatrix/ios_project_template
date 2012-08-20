//
//  RestDataSource.m
//  Template
//
//  Created by Lin Yiming on 8/20/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "RestDataSource.h"
#import "URLRequestModel.h"
#import "RequestConf.h"

@implementation RestDataSource
- (id) initWithRid:(int64_t) rid{
    if (self = [super init]) {
        URLRequestModel* restModel = [[URLRequestModel alloc] init];
        self.model = restModel;
        [restModel setRequestWithMethod:API_RESTINFO
                                 params:[NSString stringWithFormat:@"%lld",rid],nil];
    }
    return self;
}

- (void) tableViewDidLoadModel:(UITableView *)tableView{
    self.sections = [NSMutableArray array];
    self.items = [NSMutableArray array];
    
    NSDictionary* restInfo = [[(URLRequestModel*)self.model responseDict]
                              objectForKey:[NSString stringWithFormat:@"%d",API_RESTINFO]];

    NSDictionary* briefDict = [restInfo objectForKey:@"brief"];
    NSMutableArray* briefSection = [NSMutableArray array];
    for (NSString* key in briefDict) {
        NSString* value  = [NSString stringWithFormat:@"%@",[briefDict objectForKey:key]];
        TTTableSubtextItem* item = [TTTableSubtextItem itemWithText:key caption:value];
        [briefSection addObject:item];
    }
    [self.sections addObject:@"brief"];
    [self.items addObject:briefSection];
    
    NSArray* recArray = [[restInfo objectForKey:@"rec"] objectForKey:@"reasons"];
    NSMutableArray* recSection = [NSMutableArray array];
    
    for (NSString* reason in recArray) {
        TTTableTextItem* item = [TTTableTextItem itemWithText:reason];
        [recSection addObject:item];
    }
    
    [self.sections addObject:@"reason"];
    [self.items addObject:recSection];
}
@end
