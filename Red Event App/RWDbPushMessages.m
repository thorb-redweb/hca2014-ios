//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import "RWDbPushMessages.h"
#import "PushMessage.h"
#import "RWDbSchemas.h"
#import "RWDbHelper.h"
#import "RWPushMessageVM.h"
#import "RWDbInterface.h"
#import "RWDbPushMessageGroups.h"


@implementation RWDbPushMessages {
    RWDbHelper *_dbHelper;

    RWDbInterface *_db;
}

- (id)initWithHelper:(RWDbHelper *)helper dbInterface:(RWDbInterface *)dbInterface {
    if (self = [super init]) {
        _dbHelper = helper;
        _db = dbInterface;
    }
    else {NSLog(@"Database not initialized");}
    return self;
}

-(PushMessage *)getFromId:(int)messageid{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas PUSH_PUSHMESSAGEID], messageid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas PUSH_TABLENAME] predicate:predicate];

    if (fetchResults.count > 0) {
        PushMessage *pushMessage = [fetchResults objectAtIndex:0];

        return pushMessage;
    }

    return NULL;
}

-(RWPushMessageVM *)getVMFromId:(int)messageid{
    PushMessage *pushMessage = [self getFromId:messageid];
    return [[RWPushMessageVM alloc] initWithPushMessage:pushMessage];
}

- (NSArray *)getListFromGroupId:(int)groupid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas PUSH_GROUPID], groupid];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas PUSH_SENDDATE] ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas PUSH_TABLENAME] predicate:predicate sort:sortDescriptors];

    return fetchResults;
}

-(NSArray *)getVMListFromGroupId:(int)groupid{
    NSArray *fetchResults = [self getListFromGroupId:groupid];

    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (PushMessage *pushMessage in fetchResults) {
        RWPushMessageVM *vm = [[RWPushMessageVM alloc] initWithPushMessage:pushMessage];
        [vmList addObject:vm];
    }

    return vmList;
}

-(NSArray *)getVMListFromGroupIds:(NSArray *)groupids{
	NSString *stringPredicate;
	if([groupids count] > 0){
		stringPredicate = [NSString stringWithFormat:@"%@ == %d OR", [RWDbSchemas PUSH_GROUPID], [groupids[0] intValue]];
	}
    for(int i = 1; i < [groupids count]; i++){
        NSNumber *groupid = groupids[i];
        stringPredicate = [NSString stringWithFormat:@"%@ %@ == %d OR", stringPredicate, [RWDbSchemas PUSH_GROUPID], groupid.intValue];
    }
    stringPredicate = [stringPredicate substringToIndex:stringPredicate.length-3];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas PUSH_SENDDATE] ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas PUSH_TABLENAME] predicate:predicate sort:sortDescriptors];

    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (PushMessage *pushMessage in fetchResults) {
        RWPushMessageVM *vm = [[RWPushMessageVM alloc] initWithPushMessage:pushMessage];
        [vmList addObject:vm];
    }

    return vmList;
}

-(NSArray *)getVMListFromSubscribedGroups{
    NSArray *subscribedGroups = [_db.PushMessageGroups getSubscribedGroupIds];
    return [self getVMListFromGroupIds:subscribedGroups];
}
@end