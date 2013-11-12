//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RWDbSchemas.h"

@implementation RWDbSchemas

+ (NSString *)ART_TABLENAME {
    return @"Article";
}

+ (NSString *)ART_ARTICLEID {
    return @"articleid";
}

+ (NSString *)ART_ALIAS {
    return @"alias";
}

+ (NSString *)ART_CATID {
    return @"catid";
}

+ (NSString *)ART_FULLTEXT {
    return @"fulltext";
}

+ (NSString *)ART_IMAGEPATH {
    return @"image";
}

+ (NSString *)ART_INTROTEXT {
    return @"introtext";
}

+ (NSString *)ART_PUBLISHDATE {
    return @"publishdate";
}

+ (NSString *)ART_TITLE {
    return @"title";
}

+ (NSString *)EVENT_TABLENAME {
    return @"Event";
}

+ (NSString *)EVENT_EVENTID {
    return @"eventid";
}

+ (NSString *)EVENT_TITLE {
    return @"title";
}

+ (NSString *)EVENT_DETAILS {
    return @"details";
}

+ (NSString *)EVENT_SUMMARY {
    return @"summary";
}

+ (NSString *)EVENT_IMAGEPATH {
    return @"image";
}

+ (NSString *)EVENT_SUBMISSION {
    return @"submission";
}

+ (NSString *)SES_TABLENAME {
    return @"Session";
}

+ (NSString *)SES_SESSIONID {
    return @"sessionid";
}

+ (NSString *)SES_EVENT {
    return @"event";
}

+ (NSString *)SES_EVENTID {
    return @"eventid";
}

+ (NSString *)SES_VENUE {
    return @"venue";
}

+ (NSString *)SES_VENUEID {
    return @"venueid";
}

+ (NSString *)SES_TITLE {
    return @"title";
}

+ (NSString *)SES_DETAILS {
    return @"details";
}

+ (NSString *)SES_STARTDATETIME {
    return @"startdatetime";
}

+ (NSString *)SES_ENDDATETIME {
    return @"enddatetime";
}

+ (NSString *)VENUE_TABLENAME {
    return @"Venue";
}

+ (NSString *)VENUE_VENUEID {
    return @"venueid";
}

+ (NSString *)VENUE_TITLE {
    return @"title";
}

+ (NSString *)VENUE_LATITUDE {
    return @"latitude";
}

+ (NSString *)VENUE_LONGITUDE {
    return @"longitude";
}

@end