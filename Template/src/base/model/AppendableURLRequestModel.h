//
//  AppendableURLRequestModel.h
//  
//
//  Created by Yiming Lin on 11/18/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "URLRequestModel.h"

@interface AppendableURLRequestModel : URLRequestModel
@property (nonatomic) int methodWithMore;

- (void) prepareRequests;
- (void) prepareAppendRequest;

- (PBArray*) getPBArrayFromMessage: (PBGeneratedMessage*) message;
- (PBGeneratedMessage*) getMessageFromPBArray:(PBArray*) array;
@end
