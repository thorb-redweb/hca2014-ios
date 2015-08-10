//
// Created by Thorbjørn Steen on 11/18/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface RWJSONSession : NSObject
- (NSString *)SESSION_ID;

- (NSString *)EVENT_ID;

- (NSString *)VENUE_ID;

- (NSString *)TITLE;

- (NSString *)DETAILS;

- (NSString *)SUBMISSION;

- (NSString *)PRICES;

- (NSString *)STARTDATE;

- (NSString *)ENDDATE;

- (NSString *)STARTTIME;

- (NSString *)ENDTIME;

- (NSString *)SESSIONTYPE;

- (NSString *)ITEMTYPE;

- (NSString *)ACTIONTYPE;
@end