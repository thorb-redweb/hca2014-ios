//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RWAppDelegate;
@class Venue;
@class RWVenueVM;
@class RWDbHelper;
@class RWXMLStore;

@interface RWDbVenues : NSObject
- (id)initWithHelper:(RWDbHelper *)helper app:(RWAppDelegate *)app;

- (Venue *)getFromId:(int)venueid;

-(RWVenueVM *)getVMFromId:(int)venueid;

-(int)getIdFromName:(NSString *)venuename;

-(RWSessionVM *)getNextSession:(int)venueid;

- (NSArray *)getVMList;

- (NSArray *)getActiveNamesAndInsertStringAtFirstPosition:(NSString *)stringToInsert;

- (void)clear;
@end