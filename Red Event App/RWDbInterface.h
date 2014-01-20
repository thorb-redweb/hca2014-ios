//
//  RWDbInterface.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWDbArticles;
@class RWDbCommon;
@class RWDbEvents;
@class RWDbSessions;
@class RWDbVenues;
@class Article;
@class RWArticleVM;
@class Event;
@class Session;
@class RWSessionVM;
@class Venue;
@class RWXMLStore;
@class RWDbPushMessages;
@class RWDbPushMessageGroups;
@class RWDbRedUploadImages;

@interface RWDbInterface : NSObject

@property(strong, nonatomic) RWDbArticles *Articles;
@property(strong, nonatomic) RWDbCommon *Common;
@property(strong, nonatomic) RWDbEvents *Events;
@property(strong, nonatomic) RWDbPushMessages *PushMessages;
@property(strong, nonatomic) RWDbPushMessageGroups *PushMessageGroups;
@property(strong, nonatomic) RWDbRedUploadImages *RedUploadImages;
@property(strong, nonatomic) RWDbSessions *Sessions;
@property(strong, nonatomic) RWDbVenues *Venues;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context xml:(RWXMLStore *)xml;

- (void)addDatabaseDump:(NSMutableData *)data delegate:(id)delegate;

- (void)updateDatabase:(NSMutableData *)data delegate:(id)delegate;

@end
