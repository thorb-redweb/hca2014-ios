//
//  RWDump.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWHandler_DumpDatabase.h"
#import "Article.h"
#import "Event.h"
#import "Session.h"
#import "Venue.h"
#import "RWDbSchemas.h"

@implementation RWHandler_DumpDatabase {
    NSManagedObjectContext *_managedObjectContext;

    NSMutableArray *_events;
    NSMutableArray *_sessions;
    NSMutableArray *_venues;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext delegate:(id)delegate {
    if (self = [super init]) {
        _managedObjectContext = managedObjectContext;
        _delegate = delegate;
    }
    return self;
}

- (void)addDatabaseDump:(NSMutableData *)data {
	NSLog(@"start dumping to database");
    NSError *dictError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&dictError];
    if (dictError != nil) {
        NSLog(@"did fail with error");
        NSLog(@"Dictionary setup failed in RWDbInterface:addContentDump: %@", dictError.description);
		[_delegate errorOccured:[NSString stringWithFormat: @"Dictionary setup failed in RWDbInterface:addContentDump: %@", dictError.description]];
		return;
    }

    _events = [[NSMutableArray alloc] init];
    _sessions = [[NSMutableArray alloc] init];
    _venues = [[NSMutableArray alloc] init];

    for (NSDictionary *entry in dict) {
        NSString *itemtype = [entry objectForKey:@"itemtype"];

        if ([itemtype isEqual:@"sys"]) {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:[entry objectForKey:@"version"] forKey:@"dataversion"];
            [prefs synchronize];
        }
        else if ([itemtype isEqual:@"a"]) {
            [self dumpContent:entry];
        }
        else if ([itemtype isEqual:@"e"]) {
            [self dumpEvent:entry];
        }
        else if ([itemtype isEqual:@"s"]) {
            [self dumpSession:entry];
        }
        else if ([itemtype isEqual:@"v"]) {
            [self dumpVenue:entry];
        }
    }

    NSError *cxtError = nil;
    if (![_managedObjectContext save:&cxtError]) {
        NSLog(@"did fail with error");
        NSLog(@"Context save failed in RWDbInterface:dumpEvent: %@", cxtError.description);
		[_delegate errorOccured:[NSString stringWithFormat: @"Context save failed in RWDbInterface:dumpEvent: %@", cxtError.description]];
		return;
    }

    NSLog(@"Dump Complete");

    [_delegate continueAfterDump];
}

- (void)dumpContent:(NSDictionary *)entry {
    Article *content = (Article *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas ART_TABLENAME] inManagedObjectContext:_managedObjectContext];
    [content setArticleid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"articleid"]]];
    [content setCatid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"catid"]]];
    [content setTitle:[self removeBackSlashes:[entry objectForKey:@"title"]]];
	[content setAlias:[self removeBackSlashes:[entry objectForKey:@"alias"]]];
    [content setIntrotext:[self removeBackSlashes:[entry objectForKey:@"introtext"]]];
    [content setFulltext:[self removeBackSlashes:[entry objectForKey:@"fulltext"]]];
    if (!([[entry objectForKey:@"introimagepath"] isKindOfClass:[NSNull class]])) {
        [content setIntroimagepath:[self removeBackSlashes:[entry objectForKey:@"introimagepath"]]];
    }
    else {
        [content setIntroimagepath:@""];
    }
    if (!([[entry objectForKey:@"mainimagepath"] isKindOfClass:[NSNull class]])) {
        [content setMainimagepath:[self removeBackSlashes:[entry objectForKey:@"mainimagepath"]]];
    }
    else {
        [content setMainimagepath:@""];
    }
    [content setPublishdate:[self convertStringToDate:[entry objectForKey:@"publishdate"]]];
}

- (void)dumpEvent:(NSDictionary *)entry {
    Event *event = (Event *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas EVENT_TABLENAME] inManagedObjectContext:_managedObjectContext];
    [event setEventid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"eventid"]]];
    [event setTitle:[self removeBackSlashes:[entry objectForKey:@"title"]]];
    [event setSummary:[self removeBackSlashes:[entry objectForKey:@"summary"]]];
    [event setDetails:[self removeBackSlashes:[entry objectForKey:@"details"]]];
    [event setImagepath:[self removeBackSlashes:[entry objectForKey:@"image"]]];
    [event setSubmission:[self removeBackSlashes:[entry objectForKey:@"submission"]]];

    [_events addObject:event];
    for (Session *session in _sessions) {
        if (session.eventid == event.eventid) {
            session.event = event;
        }
    }
}

- (void)dumpSession:(NSDictionary *)entry {
    Session *session = (Session *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas SES_TABLENAME] inManagedObjectContext:_managedObjectContext];
    [session setSessionid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"sessionid"]]];
    [session setEventid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"eventid"]]];
    [session setVenueid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"venueid"]]];
    [session setTitle:[self removeBackSlashes:[entry objectForKey:@"title"]]];
    [session setDetails:[self removeBackSlashes:[entry objectForKey:@"details"]]];

    NSString *startDateString = [entry objectForKey:@"startdate"];
    NSString *startTimeString = [entry objectForKey:@"starttime"];
    NSString *startDateTimeString = [NSString stringWithFormat:@"%@ %@", startDateString, startTimeString];
    NSDate *startDateTime = [self convertStringToDate:startDateTimeString];
    [session setStartdatetime:startDateTime];

    NSString *endDateString = [entry objectForKey:@"enddate"];
    NSString *endTimeString = [entry objectForKey:@"endtime"];
    NSString *endDateTimeString = [NSString stringWithFormat:@"%@ %@", endDateString, endTimeString];
    NSDate *endDateTime = [self convertStringToDate:endDateTimeString];
    [session setEnddatetime:endDateTime];

    [_sessions addObject:session];
    for (Event *event in _events) {
        if (session.eventid == event.eventid) {
            session.event = event;
        }
    }
    for (Venue *venue in _venues) {
        if (session.venueid == venue.venueid) {
            session.venue = venue;
        }
    }
}

- (void)dumpVenue:(NSDictionary *)entry {
    Venue *venue = (Venue *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas VENUE_TABLENAME] inManagedObjectContext:_managedObjectContext];
    [venue setVenueid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"venueid"]]];
    [venue setTitle:[self removeBackSlashes:[entry objectForKey:@"title"]]];
    [venue setDescript:[self removeBackSlashes:[entry objectForKey:@"description"]]];
    [venue setStreet:[self removeBackSlashes:[entry objectForKey:@"street"]]];
    [venue setCity:[self removeBackSlashes:[entry objectForKey:@"city"]]];
    [venue setLatitude:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"latitude"]]];
    [venue setLongitude:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:@"longitude"]]];
    [venue setImagepath:[self removeBackSlashes:[entry objectForKey:@"imagepath"]]];

    [_venues addObject:venue];
    for (Session *session in _sessions) {
        if (session.venueid == venue.venueid) {
            session.venue = venue;
        }
    }
}

- (NSDate *)convertStringToDate:(NSString *)dateString {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingAllTypes error:nil];
    __block NSDate *myDate;
    [detector enumerateMatchesInString:dateString options:kNilOptions range:NSMakeRange(0, dateString.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        myDate = result.date;
    }];
    return myDate;
}

- (NSString *)removeBackSlashes:(NSString *)string{
	return [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
}

@end
