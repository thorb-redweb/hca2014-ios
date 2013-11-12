//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RWDbSessions.h"
#import "RWDbHelper.h"
#import "RWDbSchemas.h"
#import "NSDate+RWDate.h"
#import "RWSessionVM.h"
#import "RWXMLStore.h"


@implementation RWDbSessions {
    RWDbHelper *_dbHelper;
	RWXMLStore *_xml;
}
- (id)initWithHelper:(RWDbHelper *)helper xml:(RWXMLStore *)xml{
    if (self = [super init]) {
        _dbHelper = helper;
		_xml = xml;
    }
    else {NSLog(@"Database not initialized");}
    return self;
}

#pragma Session Item Functions

- (Session *)getFromId:(int)sessionid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas SES_SESSIONID], sessionid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate];

    if (fetchResults.count > 0) {
        Session *session = [fetchResults objectAtIndex:0];

        return session;
    }

    return NULL;
}

- (Session *)getFromEventId:(int)eventid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas SES_EVENTID], eventid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate];

    if (fetchResults.count > 0) {
        Session *session = [fetchResults objectAtIndex:0];

        return session;
    }

    return NULL;
}

- (Session *)getFromVenueId:(int)venueid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas SES_VENUEID], venueid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate];

    if (fetchResults.count > 0) {
        Session *session = [fetchResults objectAtIndex:0];

        return session;
    }

    return NULL;
}

- (RWSessionVM *)getVMFromId:(int)sessionid {
    Session *session = [self getFromId:sessionid];
    if (session != NULL)
        return [[RWSessionVM alloc] initWithSession:session xml:_xml];
    return NULL;
}

#pragma Session List Functions

- (NSArray *)getVMList {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K != NULL AND %K != NULL", [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors];

    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Session *session in fetchResults) {
        RWSessionVM *vm = [[RWSessionVM alloc] initWithSession:session xml:_xml];
        [vmList addObject:vm];
    }

    return vmList;
}

- (NSArray *)getNextThreeVMs:(NSDate *)datetime {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K >= %@ AND %K != nil AND %K != nil",
                                                              [RWDbSchemas SES_STARTDATETIME], datetime, [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:3];

    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Session *session in fetchResults) {
        RWSessionVM *vm = [[RWSessionVM alloc] initWithSession:session xml:_xml];
        [vmList addObject:vm];
    }

    return vmList;
}

- (NSArray *)getVMListFilteredByDate:(NSDate *)date venueid:(int)venueid {
    NSDate *startOfDay = [date roundToDate];
    NSDate *endOfDay = [date endOfDay];

    NSPredicate *predicate;
    if (venueid >= 0) {
        predicate = [NSPredicate predicateWithFormat:@"%K >= %@ AND %K <= %@ AND %K = %d AND %K != nil AND %K != nil",
                                                     [RWDbSchemas SES_STARTDATETIME], startOfDay, [RWDbSchemas SES_STARTDATETIME], endOfDay,
                                                     [RWDbSchemas SES_VENUEID], venueid, [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    }
    else {
        predicate = [NSPredicate predicateWithFormat:@"%K >= %@ AND %K <= %@ AND %K != nil AND %K != nil",
                                                     [RWDbSchemas SES_STARTDATETIME], startOfDay, [RWDbSchemas SES_STARTDATETIME], endOfDay,
                                                     [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    }

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors];

    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Session *session in fetchResults) {
        RWSessionVM *vm = [[RWSessionVM alloc] initWithSession:session xml:_xml];
        [vmList addObject:vm];
    }

    return vmList;
}

#pragma Information Functions

- (NSDate *)getStartDateTimeWithSessionByDateTime:(NSDate *)datetime venueid:(int)venueid {
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ => CAST(%f, \"NSDate\") AND %@ != nil AND %@ != nil",
								 [RWDbSchemas SES_STARTDATETIME], datetime.timeIntervalSinceReferenceDate, [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    if (venueid >= 0) {
		stringPredicate = [NSString stringWithFormat:@"%@ == %d AND %@",
						   [RWDbSchemas SES_VENUEID], venueid, stringPredicate];
    }
	NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
    NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:1];
    if (result.count > 0) {
        Session *session = [result objectAtIndex:0];
        return session.startdatetime;
    } else {
		return [self getPreviousDateTimeByDateTime:datetime venueid:venueid];
	}
}

- (NSDate *)getNextDateTimeByDateTime:(NSDate *)datetime venueid:(int)venueid {
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ > CAST(%f, \"NSDate\") AND %@ != nil AND %@ != nil",
	[RWDbSchemas SES_STARTDATETIME], datetime.timeIntervalSinceReferenceDate, [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    if (venueid >= 0) {
		stringPredicate = [NSString stringWithFormat:@"%@ == %d AND %@",
						   [RWDbSchemas SES_VENUEID], venueid, stringPredicate];
    }
	NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
    NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:1];
    if (result.count > 0) {
        Session *session = [result objectAtIndex:0];
        return session.startdatetime;
    }
    return NULL;
}

- (NSDate *)getPreviousDateTimeByDateTime:(NSDate *)datetime venueid:(int)venueid {
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ < CAST(%f, \"NSDate\") AND %@ != nil AND %@ != nil",
								 [RWDbSchemas SES_STARTDATETIME], datetime.timeIntervalSinceReferenceDate, [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    if (venueid >= 0) {
		stringPredicate = [NSString stringWithFormat:@"%@ == %d AND %@",
						   [RWDbSchemas SES_VENUEID], venueid, stringPredicate];
    }
	NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
    NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:1];
    if (result.count > 0) {
        Session *session = [result objectAtIndex:0];
        return session.startdatetime;
    }
    return NULL;
}

- (NSDate *)getLastDateTimeByVenue:(int)venueid {
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ != nil AND %@ != nil",
								 [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    if (venueid >= 0) {
		stringPredicate = [NSString stringWithFormat:@"%@ == %d AND %@",
						   [RWDbSchemas SES_VENUEID], venueid, stringPredicate];
    }
	NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];
    
//	NSPredicate *predicate = nil;
//    if (venueid >= 0) {
//        predicate = [NSPredicate predicateWithFormat:@"%K == %d AND %K != nil AND %K != nil",
//                                                     [RWDbSchemas SES_VENUEID], venueid, [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
//    }
//    else {
//        predicate = [NSPredicate predicateWithFormat:@"%K != nil AND %K != nil",
//                                                     [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
//    }

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:1];
    if (result.count > 0) {
        Session *session = [result objectAtIndex:0];
        return session.startdatetime;
    }
    return NULL;
}

- (NSDate *)getFirstDateTimeByVenue:(int)venueid {
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ != nil AND %@ != nil",
								   [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    if (venueid >= 0) {
		stringPredicate = [NSString stringWithFormat:@"%@ == %d AND %@",
					 [RWDbSchemas SES_VENUEID], venueid, stringPredicate];
    }
	NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:1];
    if (result.count > 0) {
        Session *session = [result objectAtIndex:0];
        return session.startdatetime;
    }
    return NULL;
}
@end