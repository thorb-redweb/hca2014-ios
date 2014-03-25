//
//  RWAppDelegate.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWNavigationController.h"
#import "RWDbInterface.h"
#import "RWPushMessageSubscriptionHandler.h"
#import "RWServer.h"
#import "RWXMLStore.h"

#import "RWTabBar.h"
#import "RWHandler_UpdateDatabase.h"

@interface RWAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

@property(readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(strong, nonatomic) RWNavigationController *navController;
@property(strong, nonatomic) RWDbInterface *db;
@property(strong, nonatomic) RWPushMessageSubscriptionHandler *pmh;
@property(strong, nonatomic) RWServer *sv;
@property(strong, nonatomic) RWXMLStore *xml;

@property(strong, nonatomic) UIViewController *pushMessageHandler;
@property(strong, nonatomic) NSDate *lastUpdated;

- (bool) shouldSkipUpdate;
- (NSDate *)getDebugDate;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

- (void)startNavController;

@end
