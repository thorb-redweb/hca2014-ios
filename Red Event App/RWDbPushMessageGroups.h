//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RWDbHelper;
@class PushMessageGroup;


@interface RWDbPushMessageGroups : NSObject

- (id)initWithHelper:(RWDbHelper *)helper;

- (PushMessageGroup *)getFromId:(int)groupid;

- (NSArray *)getAllVMs;

- (NSArray *)getSubscribedGroupIds;

- (void)updateSubscriptionById:(int)groupid subscribed:(bool)subscribed;
@end