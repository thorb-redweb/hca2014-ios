//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RWDbInterface;
@class RWDbHelper;
@class PushMessage;
@class RWPushMessageVM;


@interface RWDbPushMessages : NSObject

- (id)initWithHelper:(RWDbHelper *)helper dbInterface:(RWDbInterface *)dbInterface;

- (PushMessage *)getFromId:(int)messageid;

- (RWPushMessageVM *)getVMFromId:(int)messageid;

- (NSArray *)getVMListFromGroupIds:(NSArray *)groupids;

- (NSArray *)getVMListFromSubscribedGroups;
@end