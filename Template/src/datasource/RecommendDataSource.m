//
//  RecommendDataSource.m
//  Template
//
//  Created by Lin Yiming on 8/20/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "RecommendDataSource.h"
#import "RecommendModel.h"
#import "RequestConf.h"

@implementation RecommendDataSource
- (id) init{
    self = [super init];
    if (self) {
        RecommendModel* recommendModel = [[RecommendModel alloc] init];
        self.model = recommendModel;
        recommendModel.responseFormat = FormatProtocolBuffer;
    }
    return self;
}

- (void) tableViewDidLoadModel:(UITableView *)tableView {
    MsgRestInfos *restInfos = [[(URLRequestModel *) self.model responseDict]
                               objectForKey:[NSString stringWithFormat:@"%d", API_RECOMMEND]];
    
    int restRecCount = restInfos.rests.count;
    
    int page = [(URLRequestModel*)self.model page];
    
    int startIndex=0;
    int lastIndex = MIN(restRecCount, [(URLRequestModel *)self.model getModelCapacity])- 1;
    if (1==page) {
        self.items = nil;
        self.items = [NSMutableArray arrayWithCapacity:restRecCount];
    }else{
        startIndex = self.items.count;
    }

    
    for (int item_num = startIndex; item_num <= lastIndex; item_num++) {
        MsgRestInfo *restInfo = [restInfos restsAtIndex:item_num];
        
        NSString *url = [NSString stringWithFormat:@"iri://rest?id=%lld",
                         restInfo.brief.id];
        TTTableTextItem* item = [TTTableTextItem itemWithText:restInfo.brief.name URL:url];
        [self.items addObject:item];
    }
}
@end
