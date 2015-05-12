//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "RWDbEvents.h"
#import "RWDbHelper.h"
#import "Event.h"
#import "RWDbSchemas.h"


@implementation RWDbEvents {
    RWDbHelper *_dbHelper;
}
- (id)initWithHelper:(RWDbHelper *)helper {
    if (self = [super init]) {
        _dbHelper = helper;
    }
    else {NSLog(@"RWDbEvents not initialized");}
    return self;
}

#pragma Event Item Functions

- (Event *)getFromId:(int)eventid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas EVENT_EVENTID], eventid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas EVENT_TABLENAME] predicate:predicate];

    if (fetchResults.count > 0) {
        Event *event = [fetchResults objectAtIndex:0];

        return event;
    }

    return NULL;
}

@end