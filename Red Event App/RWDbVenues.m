//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "MyLog.h"

#import "RWDbVenues.h"
#import "RWDbHelper.h"
#import "RWDbSchemas.h"
#import "RWVenueVM.h"


@implementation RWDbVenues {
    RWDbHelper *_dbHelper;
	RWXMLStore *_xml;
}
- (id)initWithHelper:(RWDbHelper *)helper xml:(RWXMLStore *)xml{
    if (self = [super init]) {
        _dbHelper = helper;
		_xml = xml;
    }
    else {DDLogWarn(@"RWDbVenues not initialized");}
    return self;
}

#pragma Venue Item Functions

- (Venue *)getFromId:(int)venueid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas VENUE_VENUEID], venueid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas VENUE_TABLENAME] predicate:predicate];

    if (fetchResults.count > 0) {
        Venue *venue = [fetchResults objectAtIndex:0];

        return venue;
    }

    return NULL;
}

-(RWVenueVM *)getVMFromId:(int)venueid{
	Venue *rawVenue = [self getFromId:venueid];
	return [[RWVenueVM alloc] initWithVenue:rawVenue xml:_xml];
}

#pragma Venue List Functions

- (NSArray *)getVMList {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas VENUE_TITLE] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas VENUE_TABLENAME] sort:sortDescriptors];

    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Venue *venue in fetchResults) {
        RWVenueVM *vm = [[RWVenueVM alloc] initWithVenue:venue xml:_xml];
        [vmList addObject:vm];
    }

    return vmList;
}
@end