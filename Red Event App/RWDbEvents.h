//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RWDbHelper;
@class Event;

@interface RWDbEvents : NSObject
- (id)initWithHelper:(RWDbHelper *)helper;

- (Event *)getFromId:(int)eventid;
@end