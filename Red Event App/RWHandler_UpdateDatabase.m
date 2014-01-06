//
//  RWHandler_UpdateDatabase.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/2/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWHandler_UpdateDatabase.h"

#import "Article.h"
#import "Event.h"
#import "Session.h"
#import "Venue.h"
#import "RWDbArticles.h"
#import "RWDbEvents.h"
#import "RWDbSessions.h"
#import "RWDbVenues.h"
#import "RWDbSchemas.h"
#import "RWJSONSchemas.h"
#import "RWJSONArticle.h"
#import "RWJSONEvent.h"
#import "RWJSONSession.h"
#import "RWJSONVenue.h"
#import "RWJSONPushMessage.h"
#import "RWJSONPushMessageGroup.h"
#import "PushMessage.h"
#import "RWDbPushMessages.h"
#import "RWDbPushMessageGroups.h"
#import "PushMessageGroup.h"

@implementation RWHandler_UpdateDatabase {
    NSManagedObjectContext *_managedObjectContext;

    RWJSONSchemas *_json;

    RWDbInterface *_db;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext parent:(RWDbInterface *)db delegate:(id)delegate {
    if (self = [super init]) {
        _managedObjectContext = managedObjectContext;
        _db = db;
        _delegate = delegate;
        _json = [[RWJSONSchemas alloc] init];
    }
    return self;
}

- (void)updateDatabase:(NSMutableData *)data {
	if (data.length == 0) {
		DDLogInfo(@"No update data received. No update necessary.");
		[_delegate continueAfterUpdate];
		return;
	}
    NSError *dictError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&dictError];
    if (dictError != nil) {
        DDLogError(@"did fail with error");
        DDLogError(@"Dictionary setup failed in RWDbInterface:updateDatabase: %@", dictError.description);
		[_delegate errorOccured:[NSString stringWithFormat: @"Dictionary setup failed in RWDbInterface:updateDatabase: %@", dictError.description]];
		return;
    }

    for (NSDictionary *entry in dict) {
        NSString *itemtype = [entry objectForKey:@"itemtype"];

		if([itemtype isEqual:@"sys"]){
			NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			[prefs setObject:[entry objectForKey:@"version"] forKey:@"dataversion"];
			[prefs synchronize];
			DDLogInfo(@"Database updated to version: %@", [entry objectForKey:@"version"]);
		}
		else{
			NSString *actiontype = [entry objectForKey:@"actiontype"];
			if([actiontype isEqual:@"c"]){
				[self updateEntry:entry];
			}
			else if([actiontype isEqual:@"d"]){
				[self deleteEntry:entry];
			}
		}
    }

    DDLogVerbose(@"Update Complete");

    [_delegate continueAfterUpdate];
}

- (void)updateEntry:(NSDictionary *)entry{
	NSString *itemtype = [entry objectForKey:@"itemtype"];
	if([itemtype isEqual:@"a"]){
		DDLogDebug(@"c %@: %@",itemtype,[entry objectForKey:_json.Art.ARTICLE_ID]);
		[self updateArticle:entry];
	} else if([itemtype isEqual:@"e"]){
		DDLogDebug(@"c %@: %@",itemtype,[entry objectForKey:_json.Event.EVENT_ID]);
		[self updateEvent:entry];
    } else if([itemtype isEqual:@"pm"]){
        DDLogDebug(@"c %@: %@",itemtype,[entry objectForKey:_json.Push.PUSHMESSAGE_ID]);
        [self updatePushMessage:entry];
    } else if([itemtype isEqual:@"pmg"]){
        DDLogDebug(@"c %@: %@",itemtype,[entry objectForKey:_json.PushGroup.GROUP_ID]);
        [self updatePushMessageGroup:entry];
    } else if([itemtype isEqual:@"s"]){
		DDLogDebug(@"c %@: %@",itemtype,[entry objectForKey:_json.Ses.SESSION_ID]);
		[self updateSession:entry];
	} else if([itemtype isEqual:@"v"]){
		DDLogDebug(@"c %@: %@",itemtype,[entry objectForKey:_json.Venue.VENUE_ID]);
		[self updateVenue:entry];
	} else {
		DDLogWarn(@"Unknown itemtype at itemcreation");
	}
}

- (void)deleteEntry:(NSDictionary *)entry{
	NSString *itemtype = [entry objectForKey:@"itemtype"];
	if([itemtype isEqual:@"a"]){
		[self deleteArticle:entry];
	} else if([itemtype isEqual:@"e"]){
		[self deleteEvent:entry];
    } else if([itemtype isEqual:@"pm"]){
        [self deletePushMessage:entry];
    } else if([itemtype isEqual:@"pmg"]){
        [self deletePushMessageGroup:entry];
	} else if([itemtype isEqual:@"s"]){
		[self deleteSession:entry];
	} else if([itemtype isEqual:@"v"]){
		[self deleteVenue:entry];
	} else {
		DDLogWarn(@"Unknown itemtype at itemdeletion");
	}
}

- (void)updateArticle:(NSDictionary *)entry {
    int contentid = [[entry objectForKey:_json.Art.ARTICLE_ID] intValue];
    Article *article = [_db.Articles getFromId:contentid];
    if (!article) {
        article = (Article *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas ART_TABLENAME] inManagedObjectContext:_managedObjectContext];
    }

    [article setArticleid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Art.ARTICLE_ID]]];
    [article setCatid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Art.CATID]]];
    [article setTitle:[self removeBackSlashes:[entry objectForKey:_json.Art.TITLE]]];
    [article setAlias:[self removeBackSlashes:[entry objectForKey:_json.Art.ALIAS]]];
    [article setIntrotext:[self removeBackSlashes:[entry objectForKey:_json.Art.INTROTEXT]]];
    [article setFulltext:[self removeBackSlashes:[entry objectForKey:_json.Art.FULLTEXT]]];
    if (!([[entry objectForKey:_json.Art.INTROIMAGEPATH] isKindOfClass:[NSNull class]])) {
        [article setIntroimagepath:[self removeBackSlashes:[entry objectForKey:_json.Art.INTROIMAGEPATH]]];
    }
    else {
        [article setIntroimagepath:@""];
    }
    if (!([[entry objectForKey:_json.Art.MAINIMAGEPATH] isKindOfClass:[NSNull class]])) {
        [article setMainimagepath:[self removeBackSlashes:[entry objectForKey:_json.Art.MAINIMAGEPATH]]];
    }
    else {
        [article setMainimagepath:@""];
    }

    [article setPublishdate:[self convertStringToDate:[entry objectForKey:_json.Art.PUBLISHDATE]]];

    NSError *cxtError = nil;
    if (![_managedObjectContext save:&cxtError]) {
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWHandler_UpdateDatabase:updateArticle: %@", cxtError.description);
    }
}

- (void)updateEvent:(NSDictionary *)entry {
    int eventid = [[entry objectForKey:_json.Event.EVENT_ID] intValue];
    Event *event = [_db.Events getFromId:eventid];
    if (!event) {
        event = (Event *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas EVENT_TABLENAME] inManagedObjectContext:_managedObjectContext];
    }

    [event setEventid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Event.EVENT_ID]]];
    [event setTitle:[self removeBackSlashes:[entry objectForKey:_json.Event.TITLE]]];
    [event setSummary:[self removeBackSlashes:[entry objectForKey:_json.Event.SUMMARY]]];
    [event setDetails:[self removeBackSlashes:[entry objectForKey:_json.Event.DETAILS]]];
    [event setImagepath:[self removeBackSlashes:[entry objectForKey:_json.Event.IMAGEPATH]]];
    [event setSubmission:[self removeBackSlashes:[entry objectForKey:_json.Event.SUBMISSION]]];

    NSArray *sessions = [_db.Sessions getListFromEventId:[[entry objectForKey:_json.Event.EVENT_ID] intValue]];
    if (sessions) {
        for(Session *session in sessions){
            session.event = event;
        }
    }
    NSError *cxtError = nil;
    if (![_managedObjectContext save:&cxtError]) {
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWHandler_UpdateDatabase:updateEvent: %@", cxtError.description);
    }
}

- (void)updatePushMessage:(NSDictionary *)entry {
    int messageid = [[entry objectForKey:_json.Push.PUSHMESSAGE_ID] intValue];
    PushMessage *pushMessage = [_db.PushMessages getFromId:messageid];
    if (!pushMessage) {
        pushMessage = (PushMessage *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas PUSH_TABLENAME] inManagedObjectContext:_managedObjectContext];
    }

    [pushMessage setPushmessageid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Push.PUSHMESSAGE_ID]]];
    [pushMessage setGroupid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Push.GROUP_ID]]];
    [pushMessage setIntro:[self removeBackSlashes:[entry objectForKey:_json.Push.INTRO]]];
    [pushMessage setMessage:[self removeBackSlashes:[entry objectForKey:_json.Push.MESSAGE]]];
    [pushMessage setAuthor:[self removeBackSlashes:[entry objectForKey:_json.Push.AUTHOR]]];
	
	NSString *dateString = [entry objectForKey:_json.Push.SENDDATE];
    NSDate *dateTime = [self convertStringToDate:dateString];
	[pushMessage setSenddate:dateTime];

    PushMessageGroup *group = [_db.PushMessageGroups getFromId:[[entry objectForKey:_json.Push.GROUP_ID] intValue]];
    if (group) {
        pushMessage.group = group;
    }
    NSError *cxtError = nil;
    if (![_managedObjectContext save:&cxtError]) {
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWHandler_UpdateDatabase:updatePushMessage: %@", cxtError.description);
    }
}

- (void)updatePushMessageGroup:(NSDictionary *)entry {
    int groupid = [[entry objectForKey:_json.PushGroup.GROUP_ID] intValue];
    PushMessageGroup *group = [_db.PushMessageGroups getFromId:groupid];
    if (!group) {
        group = (PushMessageGroup *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas PUSHGROUP_TABLENAME] inManagedObjectContext:_managedObjectContext];
    }

    [group setGroupid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.PushGroup.GROUP_ID]]];
    [group setName:[self removeBackSlashes:[entry objectForKey:_json.PushGroup.NAME]]];

    NSArray *pushMessages = [_db.PushMessages getListFromGroupId:[[entry objectForKey:_json.Event.EVENT_ID] intValue]];
    if (pushMessages) {
        for(PushMessage *message in pushMessages) {
            message.group = group;
        }
    }
    NSError *cxtError = nil;
    if (![_managedObjectContext save:&cxtError]) {
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWHandler_UpdateDatabase:updatePushMessageGroup: %@", cxtError.description);
    }
}

- (void)updateSession:(NSDictionary *)entry {
    int sessionid = [[entry objectForKey:_json.Ses.SESSION_ID] intValue];
    Session *session = [_db.Sessions getFromId:sessionid];
    if (!session) {
        session = (Session *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas SES_TABLENAME] inManagedObjectContext:_managedObjectContext];
    }

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

    Event *event = [_db.Events getFromId:[[entry objectForKey:_json.Ses.EVENT_ID] intValue]];
    if (event) {
        session.event = event;
    }
    Venue *venue = [_db.Venues getFromId:[[entry objectForKey:_json.Ses.VENUE_ID] intValue]];
    if (venue) {
        session.venue = venue;
    }

    NSError *cxtError = nil;
    if (![_managedObjectContext save:&cxtError]) {
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWHandler_UpdateDatabase:updateSession: %@", cxtError.description);
    }
}

- (void)updateVenue:(NSDictionary *)entry {
    int venueid = [[entry objectForKey:_json.Venue.VENUE_ID] intValue];
    Venue *venue = [_db.Venues getFromId:venueid];
    if (!venue) {
        venue = (Venue *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas VENUE_TABLENAME] inManagedObjectContext:_managedObjectContext];
    }

    [venue setVenueid:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Venue.VENUE_ID]]];
    [venue setTitle:[self removeBackSlashes:[entry objectForKey:_json.Venue.TITLE]]];
    [venue setDescript:[self removeBackSlashes:[entry objectForKey:_json.Venue.DESCRIPTION]]];
    [venue setStreet:[self removeBackSlashes:[entry objectForKey:_json.Venue.STREET]]];
    [venue setCity:[self removeBackSlashes:[entry objectForKey:_json.Venue.CITY]]];
    [venue setLatitude:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Venue.LATITUDE]]];
    [venue setLongitude:[NSDecimalNumber decimalNumberWithString:[entry objectForKey:_json.Venue.LONGITUDE]]];
    [venue setImagepath:[self removeBackSlashes:[entry objectForKey:_json.Venue.IMAGEPATH]]];

    NSArray *sessions = [_db.Sessions getListFromVenueId:venueid];
    if (sessions) {
        for(Session *session in sessions){
            session.venue = venue;
        }
    }

    NSError *cxtError = nil;
    if (![_managedObjectContext save:&cxtError]) {
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWHandler_UpdateDatabase:updateVenue: %@", cxtError.description);
    }
}

- (void)deleteArticle:(NSDictionary *)entry {
    int contentid = [[entry objectForKey:_json.Art.ARTICLE_ID] intValue];
    Article *article = [_db.Articles getFromId:contentid];
	if(article != nil){
		[_managedObjectContext deleteObject:article];
	}
}

- (void)deleteEvent:(NSDictionary *)entry {
    int eventid = [[entry objectForKey:_json.Event.EVENT_ID] intValue];
    Event *event = [_db.Events getFromId:eventid];
    if(event != nil){
		[_managedObjectContext deleteObject:event];
	}
}

- (void)deletePushMessage:(NSDictionary *)entry {
    int messageid = [[entry objectForKey:_json.Push.PUSHMESSAGE_ID] intValue];
    PushMessage *pushMessage = [_db.PushMessages getFromId:messageid];
    if(pushMessage != nil){
        [_managedObjectContext deleteObject:pushMessage];
    }
}

- (void)deletePushMessageGroup:(NSDictionary *)entry {
    int groupid = [[entry objectForKey:_json.PushGroup.GROUP_ID] intValue];
    PushMessageGroup *group = [_db.PushMessageGroups getFromId:groupid];
    if(group != nil){
        [_managedObjectContext deleteObject:group];
    }
}

- (void)deleteSession:(NSDictionary *)entry {
    int sessionid = [[entry objectForKey:_json.Ses.SESSION_ID] intValue];
    Session *session = [_db.Sessions getFromId:sessionid];
    if(session != nil){
		[_managedObjectContext deleteObject:session];
	}
}

- (void)deleteVenue:(NSDictionary *)entry {
    int venueid = [[entry objectForKey:_json.Venue.VENUE_ID] intValue];
    Venue *venue = [_db.Venues getFromId:venueid];
    if(venue != nil){
		[_managedObjectContext deleteObject:venue];
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
