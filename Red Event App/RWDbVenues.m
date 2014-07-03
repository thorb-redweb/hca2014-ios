//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "MyLog.h"

#import "RWAppDelegate.h"
#import "RWDbVenues.h"
#import "RWDbHelper.h"
#import "RWDbSchemas.h"
#import "RWVenueVM.h"
#import "RWSessionVM.h"
#import "RWDbSessions.h"


@implementation RWDbVenues {
	RWAppDelegate *_app;
    RWDbHelper *_dbHelper;
	RWXMLStore *_xml;
}
- (id)initWithHelper:(RWDbHelper *)helper app:(RWAppDelegate *)app{
    if (self = [super init]) {
        _dbHelper = helper;
		_app = app;
		_xml = app.xml;
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

-(int)getIdFromName:(NSString *)venuename{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", [RWDbSchemas VENUE_TITLE], venuename];
	
    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas VENUE_TABLENAME] predicate:predicate];
	
    if (fetchResults.count > 0) {
        Venue *venue = [fetchResults objectAtIndex:0];
		
        return [venue.venueid intValue];
    }
	
    return -1;

}

-(RWSessionVM *)getNextSession:(int)venueid{
	NSDate *currentDate = [[NSDate alloc] init];
	if([_app getDebugDate]){
		currentDate = [_app getDebugDate];
	}

	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d AND %K => %@", [RWDbSchemas SES_VENUEID], venueid, [RWDbSchemas SES_STARTDATETIME], currentDate];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:1];
	
	if (fetchResults.count > 0) {
        Session *session = [fetchResults objectAtIndex:0];
		RWSessionVM *vm = [[RWSessionVM alloc] initWithSession:session xml:_xml];
		
        return vm;
    }	
    return NULL;
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

- (NSArray *)getActiveNamesAndInsertStringAtFirstPosition:(NSString *)stringToInsert{
    NSArray *activeIds = [_app.db.Sessions getActiveVenueIds];

    NSMutableArray *subPredicates = [NSMutableArray new];
    for(NSNumber *venueId in activeIds){
        NSPredicate *subPredicate = [NSPredicate predicateWithFormat:@"%K = %@",[RWDbSchemas VENUE_VENUEID], venueId];
        [subPredicates addObject:subPredicate];
    }
    NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];

	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas VENUE_TITLE] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas VENUE_TABLENAME] predicate:predicate sort:sortDescriptors];
	
    NSMutableArray *nameList = [[NSMutableArray alloc] initWithCapacity:0];
    [nameList addObject:stringToInsert];
    for (Venue *venue in fetchResults) {
        [nameList addObject:venue.title];
    }
	
    return nameList;
}
@end