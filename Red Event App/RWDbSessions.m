//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "MyLog.h"

#import "RWDbSessions.h"
#import "RWDbHelper.h"
#import "RWDbSchemas.h"
#import "NSDate+RWDate.h"
#import "RWSessionVM.h"
#import "RWXMLStore.h"
#import "RWAppDelegate.h"


@implementation RWDbSessions {
    RWDbHelper *_dbHelper;
	RWXMLStore *_xml;
}
- (id)initWithHelper:(RWDbHelper *)helper xml:(RWXMLStore *)xml{
    if (self = [super init]) {
        _dbHelper = helper;
		_xml = xml;
    }
    else {DDLogWarn(@"RWDbSessions not initialized");}
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

- (NSArray *)getListFromEventId:(int)eventid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas SES_EVENTID], eventid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate];

    return fetchResults;
}

- (NSArray *)getListFromVenueId:(int)venueid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas SES_VENUEID], venueid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate];

    return fetchResults;
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

- (NSArray *)getVMListFilteredByDate:(NSDate *)date venueid:(int)venueid type:(NSString *)type searchString:(NSString *)searchString {
    NSDate *startOfDay = [date roundToDate];
    NSDate *endOfDay = [date endOfDay];
    
    NSMutableArray *subPredicates = [NSMutableArray new];
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"%K >= %@ AND %K <= %@ AND %K != nil AND %K != nil",
                                                                  [RWDbSchemas SES_STARTDATETIME], startOfDay, [RWDbSchemas SES_STARTDATETIME], endOfDay,
                                                                  [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    [subPredicates addObject:datePredicate];
    if(venueid > 0){
        NSPredicate *venuePredicate = [NSPredicate predicateWithFormat:@"%K = %d",
                                                                       [RWDbSchemas SES_VENUEID], venueid];
        [subPredicates addObject:venuePredicate];
    }
    if(![type isEqualToString:@"Alle"]){
        NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"%K = %@",
                                                                      [RWDbSchemas SES_TYPE], type];
        [subPredicates addObject:typePredicate];
    }
    if(![searchString isEqualToString:@""]){
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@ OR %K contains[cd] %@",
                                                                        [RWDbSchemas SES_TITLE], searchString, [RWDbSchemas SES_DETAILS], searchString];
        [subPredicates addObject:searchPredicate];
    }
	NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];

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

- (NSDate *)getStartDateTimeWithSessionByDateTime:(NSDate *)datetime venueid:(int)venueid type:(NSString *)type searchString:(NSString *)searchString {
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"%K >= %@",
                                                                  [RWDbSchemas SES_STARTDATETIME], datetime];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    return [self getDateTimeOfFirstMatchingSessionWithDatePredicate:datePredicate sortDescriptor:sortDescriptor venueid:venueid type:type searchString:searchString];
}

- (NSDate *)getNextDateTimeByDateTime:(NSDate *)datetime venueid:(int)venueid type:(NSString *)type searchString:(NSString *)searchString {
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"%K > %@",
                                                                  [RWDbSchemas SES_STARTDATETIME], datetime];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    return [self getDateTimeOfFirstMatchingSessionWithDatePredicate:datePredicate sortDescriptor:sortDescriptor venueid:venueid type:type searchString:searchString];
}

- (NSDate *)getPreviousDateTimeByDateTime:(NSDate *)datetime venueid:(int)venueid type:(NSString *)type searchString:(NSString *)searchString {
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"%K < %@",
                                                                  [RWDbSchemas SES_STARTDATETIME], datetime];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:NO];
    return [self getDateTimeOfFirstMatchingSessionWithDatePredicate:datePredicate sortDescriptor:sortDescriptor venueid:venueid type:type searchString:searchString];
}

- (NSDate *)getLastDateTimeByVenue:(int)venueid type:(NSString *)type searchString:(NSString *)searchString {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:NO];
    return [self getDateTimeOfFirstMatchingSessionWithDatePredicate:nil sortDescriptor:sortDescriptor venueid:venueid type:type searchString:searchString];
}

- (NSDate *)getFirstDateTimeByVenue:(int)venueid type:(NSString *)type searchString:(NSString *)searchString {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas SES_STARTDATETIME] ascending:YES];
    return [self getDateTimeOfFirstMatchingSessionWithDatePredicate:nil sortDescriptor:sortDescriptor venueid:venueid type:type searchString:searchString];
}

- (NSDate *)getDateTimeOfFirstMatchingSessionWithDatePredicate:(NSPredicate *)datePredicate sortDescriptor:(NSSortDescriptor *)sortDescriptor
                                                       venueid:(int)venueid type:(NSString *)type searchString:(NSString *)searchString {
    NSMutableArray *subPredicates = [NSMutableArray new];
    if (datePredicate != nil) {
        [subPredicates addObject:datePredicate];
    }
    NSPredicate *primePredicate = [NSPredicate predicateWithFormat:@"%K != nil AND %K != nil",
                                                                  [RWDbSchemas SES_EVENT], [RWDbSchemas SES_VENUE]];
    [subPredicates addObject:primePredicate];
    if(venueid > 0){
        NSPredicate *venuePredicate = [NSPredicate predicateWithFormat:@"%K = %d",
                                                                       [RWDbSchemas SES_VENUEID], venueid];
        [subPredicates addObject:venuePredicate];
    }
    if(![type isEqualToString:@"Alle"]){
        NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"%K = %@",
                                                                      [RWDbSchemas SES_TYPE], type];
        [subPredicates addObject:typePredicate];
    }
    if(searchString != nil && ![searchString isEqualToString:@""]){
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@ OR %K contains[cd] %@",
										[RWDbSchemas SES_TITLE], searchString, [RWDbSchemas SES_DETAILS], searchString];
        [subPredicates addObject:searchPredicate];
    }
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas SES_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:1];
    if (result.count > 0) {
        Session *session = [result objectAtIndex:0];
        return session.startdatetime;
    }
    return NULL;
}

-(NSArray *)getActiveVenueIds{
    RWAppDelegate *app = (RWAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *objectContext = app.managedObjectContext;

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[RWDbSchemas SES_TABLENAME]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[RWDbSchemas SES_TABLENAME] inManagedObjectContext:objectContext];

    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:[RWDbSchemas SES_VENUEID]]];
    fetchRequest.returnsDistinctResults = YES;

// Now it should yield an NSArray of distinct values in dictionaries.
    NSArray *dictionaries = [objectContext executeFetchRequest:fetchRequest error:nil];
    NSMutableArray *activeVenueIds = [NSMutableArray new];
    for(NSDictionary *dict in dictionaries){
        [activeVenueIds addObject:dict[[RWDbSchemas SES_VENUEID]]];
    }
    return activeVenueIds;
}
@end