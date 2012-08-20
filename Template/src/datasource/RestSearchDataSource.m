//
//  RestSearchDataSource.m
//  Fanfan
//
//  Created by Lin Yiming on 7/23/12.
//  Copyright (c) 2012 Lin Yiming. All rights reserved.
//

#import "RestSearchDataSource.h"
#import "URLRequestModel.h"
#import "RequestConf.h"
#import "MOLocator.h"

@implementation RestSearchDataSource

- (id) initWithKey:(NSString*) key
{
    if (self=[super init]) {

        URLRequestModel* searchModel = [[URLRequestModel alloc] init];
        self.model  = searchModel;
        searchModel.responseFormat = FormatProtocolBuffer;
        
        NSString* longitude = [[MOLocator sharedMOLocator] longitude];
        NSString* latitude  = [[MOLocator sharedMOLocator] latitude];
        if (!longitude||latitude) {
            
            longitude = @"";
            latitude = @"";
        }
        NSString* city = @"北京";
        
        [searchModel setRequestWithMethod:API_SEARCH params:
         key,
         @"0", 
         @"21",
         longitude,
         latitude,
         city?city:EMPTYPARAMVALUE,
         nil];
    }
    return self;
}

- (Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
    return [super tableView:tableView cellClassForObject:object];
}


- (void) tableViewDidLoadModel:(UITableView *)tableView{
    MsgRestInfos *restInfos = [[(URLRequestModel *) self.model responseDict]
                               objectForKey:[NSString stringWithFormat:@"%d", API_SEARCH]];
    
    int restRecCount = restInfos.rests.count;
    
    
    self.items = [NSMutableArray arrayWithCapacity:restRecCount];
    
    for (int item_num = 0; item_num < restRecCount; item_num++) {
        MsgRestInfo *restInfo = [restInfos restsAtIndex:item_num];
        
        NSString *url = [NSString stringWithFormat:@"iri://rest?id=%lld",
                         restInfo.brief.id];
        TTTableTextItem* item = [TTTableTextItem itemWithText:restInfo.brief.name URL:url];
        [self.items addObject:item];
    }
}

#pragma mark empty 
- (NSString*) titleForEmpty{
    return NSLocalizedString(@"没有符合你要求的餐馆", nil);
}

- (UIImage*) imageForEmpty{
    return [UIImage imageNamed:@"icon_favorites_none"];
}

- (BOOL)reloadButtonForEmpty{
    return YES;
}
@end
