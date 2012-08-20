//
//  RestController.h
//  Template
//
//  Created by Lin Yiming on 8/20/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//


@interface RestController : TTTableViewController
@property (nonatomic, readonly) int64_t rid;
-  (id) initWithRid:(int64_t) rid;
@end
