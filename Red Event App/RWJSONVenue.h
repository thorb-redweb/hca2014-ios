//
// Created by Thorbjørn Steen on 11/18/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface RWJSONVenue : NSObject
- (NSString *)VENUE_ID;

- (NSString *)TITLE;

- (NSString *)DESCRIPTION;

- (NSString *)STREET;

- (NSString *)CITY;

- (NSString *)LATITUDE;

- (NSString *)LONGITUDE;

- (NSString *)IMAGEPATH;

- (NSString *)ITEMTYPE;

- (NSString *)ACTIONTYPE;
@end