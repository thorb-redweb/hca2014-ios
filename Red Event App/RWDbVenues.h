//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class Venue;
@class RWVenueVM;
@class RWDbHelper;
@class RWXMLStore;

@interface RWDbVenues : NSObject
- (id)initWithHelper:(RWDbHelper *)context xml:(RWXMLStore *)xml;

- (Venue *)getFromId:(int)venueid;

-(RWVenueVM *)getVMFromId:(int)venueid;

- (NSArray *)getVMList;
@end