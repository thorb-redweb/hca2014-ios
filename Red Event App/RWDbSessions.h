//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RWDbHelper;
@class Session;
@class RWSessionVM;

@class RWXMLStore;

@interface RWDbSessions : NSObject
- (id)initWithHelper:(RWDbHelper *)helper xml:(RWXMLStore *)xml;

- (Session *)getFromId:(int)sessionid;

- (Session *)getFromEventId:(int)eventid;

- (Session *)getFromVenueId:(int)venueid;

- (RWSessionVM *)getVMFromId:(int)sessionid;

- (NSArray *)getVMList;

- (NSArray *)getNextThreeVMs:(NSDate *)datetime;

- (NSArray *)getVMListFilteredByDate:(NSDate *)date venueid:(int)venueid;

- (NSDate *)getStartDateTimeWithSessionByDateTime:(NSDate *)datetime venueid:(int)venueid;

- (NSDate *)getNextDateTimeByDateTime:(NSDate *)datetime venueid:(int)venueid;

- (NSDate *)getPreviousDateTimeByDateTime:(NSDate *)datetime venueid:(int)venueid;

- (NSDate *)getLastDateTimeByVenue:(int)venueid;

- (NSDate *)getFirstDateTimeByVenue:(int)venueid;

@end