//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWDbPushMessageGroups.h"
#import "RWDbHelper.h"
#import "RWDbSchemas.h"
#import "PushMessageGroup.h"
#import "RWPushMessageGroupVM.h"


@implementation RWDbPushMessageGroups {

    RWDbHelper *_dbHelper;
}

- (id)initWithHelper:(RWDbHelper *)helper{
    if (self = [super init]) {
        _dbHelper = helper;
    }
    else {DDLogWarn(@"RWDbPushMessageGroups not initialized");}
    return self;
}

-(PushMessageGroup *)getFromId:(int)groupid{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas PUSHGROUP_GROUPID], groupid];

    NSArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas PUSHGROUP_TABLENAME] predicate:predicate];

	if(fetchResults.count > 0){
		return fetchResults[0];
	}
	return nil;
}

-(NSArray *)getAll{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas PUSHGROUP_NAME] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    return [_dbHelper getFromDatabase:[RWDbSchemas PUSHGROUP_TABLENAME] sort:sortDescriptors];
}

-(NSArray *)getAllVMs{
    NSArray *fetchResults = [self getAll];

    NSMutableArray *vms = [[NSMutableArray alloc] initWithCapacity:0];
    for(PushMessageGroup *group in fetchResults){
        [vms addObject:[[RWPushMessageGroupVM alloc] initWithPushMessageGroup:group]];
    }
    return vms;
}

-(NSArray *)getSubscribedGroupIds{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas PUSHGROUP_SUBSCRIBING], YES];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas PUSHGROUP_TABLENAME] predicate:predicate];

    NSMutableArray *groupIds = [[NSMutableArray alloc] initWithCapacity:0];
    for (PushMessageGroup *group in fetchResults) {
        [groupIds addObject:group.groupid];
    }
    return groupIds;
}

-(void)updateSubscriptionById:(int)groupid subscribed:(bool)subscribed{
    PushMessageGroup *group = [self getFromId:groupid];
    group.subscribing = [NSNumber numberWithBool:subscribed];
}

-(void)unsubscribeAll{
    NSArray *allGroups = [self getAll];
    for(PushMessageGroup *group in allGroups) {
        group.subscribing = [NSNumber numberWithBool:NO];
    }
}

@end