//
//  RWDbInterface.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWAppDelegate.h"
#import "RWDbHelper.h"
#import "RWDbArticles.h"
#import "RWDbCommon.h"
#import "RWDbEvents.h"
#import "RWDbSessions.h"
#import "RWDbVenues.h"
#import "RWHandler_DumpDatabase.h"
#import "RWDbPushMessages.h"
#import "RWDbPushMessageGroups.h"


@interface RWDbInterface ()

@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation RWDbInterface {
    RWDbHelper *_dbHelper;
	RWXMLStore *_xml;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context xml:(RWXMLStore *)xml{
    if (self = [super init]) {
        _managedObjectContext = context;

		RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
        _dbHelper = [[RWDbHelper alloc] initWithManagedObjectContext:_managedObjectContext];
		_xml = xml;

        _Articles = [[RWDbArticles alloc] initWithHelper:_dbHelper xml:_xml];
        _Common = [[RWDbCommon alloc] initWithHelper:_dbHelper];
        _Events = [[RWDbEvents alloc] initWithHelper:_dbHelper];
        _PushMessages = [[RWDbPushMessages alloc] initWithHelper:_dbHelper dbInterface:self];
        _PushMessageGroups = [[RWDbPushMessageGroups alloc] initWithHelper:_dbHelper];
        _Sessions = [[RWDbSessions alloc] initWithHelper:_dbHelper xml:_xml];
        _Venues = [[RWDbVenues alloc] initWithHelper:_dbHelper app:app];
    }
    else {NSLog(@"Database not initialized");}
    return self;
}

#pragma Dump Functions

- (void)addDatabaseDump:(NSMutableData *)data delegate:(id)delegate {
    RWHandler_DumpDatabase *dumper = [[RWHandler_DumpDatabase alloc] initWithManagedObjectContext:_managedObjectContext delegate:delegate];
    [dumper addDatabaseDump:data];
}

- (void)updateDatabase:(NSMutableData *)data delegate:(id)delegate {
    RWHandler_UpdateDatabase *updater = [[RWHandler_UpdateDatabase alloc] initWithManagedObjectContext:_managedObjectContext parent:self delegate:delegate];
    [updater updateDatabase:data];
}


@end
