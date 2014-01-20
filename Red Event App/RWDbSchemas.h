//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface RWDbSchemas : NSObject
+ (NSString *)ART_TABLENAME;

+ (NSString *)ART_ARTICLEID;

+ (NSString *)ART_ALIAS;

+ (NSString *)ART_CATID;

+ (NSString *)ART_FULLTEXT;

+ (NSString *)ART_IMAGEPATH;

+ (NSString *)ART_INTROTEXT;

+ (NSString *)ART_PUBLISHDATE;

+ (NSString *)ART_TITLE;

+ (NSString *)EVENT_TABLENAME;

+ (NSString *)EVENT_EVENTID;

+ (NSString *)EVENT_TITLE;

+ (NSString *)EVENT_DETAILS;

+ (NSString *)EVENT_SUMMARY;

+ (NSString *)EVENT_IMAGEPATH;

+ (NSString *)EVENT_SUBMISSION;

+ (NSString *)PUSH_TABLENAME;

+ (NSString *)PUSH_PUSHMESSAGEID;

+ (NSString *)PUSH_GROUPID;

+ (NSString *)PUSH_INTRO;

+ (NSString *)PUSH_MESSAGE;

+ (NSString *)PUSH_AUTHOR;

+ (NSString *)PUSH_SENDDATE;

+ (NSString *)PUSHGROUP_TABLENAME;

+ (NSString *)PUSHGROUP_GROUPID;

+ (NSString *)PUSHGROUP_NAME;

+ (NSString *)PUSHGROUP_SUBSCRIBING;

+ (NSString *)RUI_TABLENAME;

+ (NSString *)RUI_LOCALIMAGEPATH;

+ (NSString *)RUI_SERVERFOLDER;

+ (NSString *)SES_TABLENAME;

+ (NSString *)SES_SESSIONID;

+ (NSString *)SES_EVENT;

+ (NSString *)SES_EVENTID;

+ (NSString *)SES_VENUE;

+ (NSString *)SES_VENUEID;

+ (NSString *)SES_TITLE;

+ (NSString *)SES_DETAILS;

+ (NSString *)SES_STARTDATETIME;

+ (NSString *)SES_ENDDATETIME;

+ (NSString *)VENUE_TABLENAME;

+ (NSString *)VENUE_VENUEID;

+ (NSString *)VENUE_TITLE;

+ (NSString *)VENUE_LATITUDE;

+ (NSString *)VENUE_LONGITUDE;
@end