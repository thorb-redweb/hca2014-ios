//
//  RWDump.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//
#import "MyLog.h"

#import "RWHandler_DumpDatabase.h"
#import "Article.h"
#import "Event.h"
#import "Session.h"
#import "Venue.h"
#import "RWDbSchemas.h"
#import "RWJSONSchemas.h"
#import "RWJSONArticle.h"
#import "RWJSONEvent.h"
#import "RWJSONSession.h"
#import "RWJSONVenue.h"
#import "PushMessage.h"
#import "RWJSONPushMessage.h"
#import "PushMessageGroup.h"
#import "RWJSONPushMessageGroup.h"

@implementation RWHandler_DumpDatabase {
    NSManagedObjectContext *_managedObjectContext;

    RWJSONSchemas *_json;

    NSMutableArray *_events;
    NSMutableArray *_sessions;
    NSMutableArray *_venues;

    NSMutableArray *_pushMessages;
    NSMutableArray *_pushMessageGroups;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext delegate:(id)delegate {
    if (self = [super init]) {
        _managedObjectContext = managedObjectContext;
        _delegate = delegate;
        _json = [[RWJSONSchemas alloc] init];
    }
    return self;
}

- (void)addDatabaseDump:(NSMutableData *)data {
	DDLogVerbose(@"start dumping to database");
    NSError *dictError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&dictError];
    if (dictError != nil) {
        DDLogError(@"did fail with error");
        DDLogError(@"Dictionary setup failed in RWDbInterface:addContentDump: %@", dictError.description);
		[_delegate errorOccured:[NSString stringWithFormat: @"Dictionary setup failed in RWDbInterface:addContentDump: %@", dictError.description]];
		return;
    }

    _events = [[NSMutableArray alloc] init];
    _sessions = [[NSMutableArray alloc] init];
    _venues = [[NSMutableArray alloc] init];

    _pushMessages = [[NSMutableArray alloc] init];
    _pushMessageGroups = [[NSMutableArray alloc] init];

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
        else if ([itemtype isEqual:@"pm"]) {
            [self dumpPushMessage:entry];
        }
        else if ([itemtype isEqual:@"pmg"]) {
            [self dumpPushMessageGroup:entry];
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
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWDbInterface:dumpEvent: %@", cxtError.description);
		[_delegate errorOccured:[NSString stringWithFormat: @"Context save failed in RWDbInterface:dumpEvent: %@", cxtError.description]];
		return;
    }

    DDLogVerbose(@"Dump Complete");

    [_delegate continueAfterDump];
}

- (void)dumpContent:(NSDictionary *)entry {
    Article *content = (Article *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas ART_TABLENAME] inManagedObjectContext:_managedObjectContext];
    [content setArticleid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Art.ARTICLE_ID]]];
    [content setCatid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Art.CATID]]];
    [content setTitle:[self removeBackSlashes:[entry objectForKey:_json.Art.TITLE]]];
	[content setAlias:[self removeBackSlashes:[entry objectForKey:_json.Art.ALIAS]]];
    [content setIntrotext:[self removeBackSlashes:[entry objectForKey:_json.Art.INTROTEXT]]];
    [content setFulltext:[self removeBackSlashes:[entry objectForKey:_json.Art.FULLTEXT]]];
    if (!([[entry objectForKey:_json.Art.INTROIMAGEPATH] isKindOfClass:[NSNull class]])) {
        [content setIntroimagepath:[self removeBackSlashes:[entry objectForKey:_json.Art.INTROIMAGEPATH]]];
    }
    else {
        [content setIntroimagepath:@""];
    }
    if (!([[entry objectForKey:_json.Art.MAINIMAGEPATH] isKindOfClass:[NSNull class]])) {
        [content setMainimagepath:[self removeBackSlashes:[entry objectForKey:_json.Art.MAINIMAGEPATH]]];
    }
    else {
        [content setMainimagepath:@""];
    }
    [content setPublishdate:[self convertStringToDate:[entry objectForKey:_json.Art.PUBLISHDATE]]];
}

- (void)dumpEvent:(NSDictionary *)entry {
    Event *event = (Event *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas EVENT_TABLENAME] inManagedObjectContext:_managedObjectContext];
    [event setEventid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Event.EVENT_ID]]];
    [event setTitle:[self removeBackSlashes:[entry objectForKey:_json.Event.TITLE]]];
    [event setSummary:[self removeBackSlashes:[entry objectForKey:_json.Event.SUMMARY]]];
    [event setDetails:[self removeBackSlashes:[entry objectForKey:_json.Event.DETAILS]]];
    [event setImagepath:[self removeBackSlashes:[entry objectForKey:_json.Event.IMAGEPATH]]];
    [event setSubmission:[self removeBackSlashes:[entry objectForKey:_json.Event.SUBMISSION]]];

    [_events addObject:event];
    for (Session *session in _sessions) {
        if (session.eventid == event.eventid) {
            session.event = event;
        }
    }
}

- (void)dumpPushMessage:(NSDictionary *)entry {
    PushMessage *pushMessage = (PushMessage *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas PUSH_TABLENAME] inManagedObjectContext:_managedObjectContext];

    [pushMessage setPushmessageid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Push.PUSHMESSAGE_ID]]];
    [pushMessage setGroupid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Push.GROUP_ID]]];
    [pushMessage setIntro:[self removeBackSlashes:[entry objectForKey:_json.Push.INTRO]]];
    [pushMessage setMessage:[self removeBackSlashes:[entry objectForKey:_json.Push.MESSAGE]]];
    [pushMessage setAuthor:[self removeBackSlashes:[entry objectForKey:_json.Push.AUTHOR]]];

    NSString *dateString = [entry objectForKey:_json.Push.SENDDATE];
    NSDate *dateTime = [self convertStringToDate:dateString];
    [pushMessage setSenddate:dateTime];

    [_pushMessages addObject:pushMessage];
    for (PushMessageGroup *group in _pushMessageGroups) {
        if (group.groupid == pushMessage.groupid) {
            pushMessage.group = group;
        }
    }
}

- (void)dumpPushMessageGroup:(NSDictionary *)entry {
    PushMessageGroup *group = (PushMessageGroup *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas PUSHGROUP_TABLENAME] inManagedObjectContext:_managedObjectContext];

    [group setGroupid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.PushGroup.GROUP_ID]]];
    [group setName:[self removeBackSlashes:[entry objectForKey:_json.PushGroup.NAME]]];

    [_pushMessageGroups addObject:group];
    for (PushMessage *message in _pushMessages) {
        if (group.groupid == message.groupid) {
            message.group = group;
        }
    }
}

- (void)dumpSession:(NSDictionary *)entry {
    Session *session = (Session *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas SES_TABLENAME] inManagedObjectContext:_managedObjectContext];
    [session setSessionid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Ses.SESSION_ID]]];
    [session setEventid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Ses.EVENT_ID]]];
    [session setVenueid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Ses.VENUE_ID]]];
    [session setTitle:[self removeBackSlashes:[entry objectForKey:_json.Ses.TITLE]]];
    [session setDetails:[self removeBackSlashes:[entry objectForKey:_json.Ses.DETAILS]]];

    NSString *startDateString = [entry objectForKey:_json.Ses.STARTDATE];
    NSString *startTimeString = [entry objectForKey:_json.Ses.STARTTIME];
    NSString *startDateTimeString = [NSString stringWithFormat:@"%@ %@", startDateString, startTimeString];
    NSDate *startDateTime = [self convertStringToDate:startDateTimeString];
    [session setStartdatetime:startDateTime];

    NSString *endDateString = [entry objectForKey:_json.Ses.ENDDATE];
    NSString *endTimeString = [entry objectForKey:_json.Ses.ENDTIME];
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
    [venue setVenueid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Venue.VENUE_ID]]];
    [venue setTitle:[self removeBackSlashes:[entry objectForKey:_json.Venue.TITLE]]];
    [venue setDescript:[self removeBackSlashes:[entry objectForKey:_json.Venue.DESCRIPTION]]];
    [venue setStreet:[self removeBackSlashes:[entry objectForKey:_json.Venue.STREET]]];
    [venue setCity:[self removeBackSlashes:[entry objectForKey:_json.Venue.CITY]]];
    [venue setLatitude:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Venue.LATITUDE]]];
    [venue setLongitude:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Venue.LONGITUDE]]];
    [venue setImagepath:[self removeBackSlashes:[entry objectForKey:_json.Venue.IMAGEPATH]]];

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
