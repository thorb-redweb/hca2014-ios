//
//  RWAppDelegate.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>

#import "RWAppDelegate.h"

#import "RWSplashViewController.h"
#import "RWMainViewController.h"

@interface RWAppDelegate ()

@end

@implementation RWAppDelegate{
    bool _registered;
    NSDictionary *_localNotification;
	bool _debugSkipUpdates;
}

- (bool) shouldSkipUpdate{ return _debugSkipUpdates; }

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSDate *)getDebugDate{
	bool debugging = NO;
	if (debugging) {
		int year = 2013;
		int month = 8;
		int day = 24;
		int hour = 13;
		int minute = 54;
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		[components setYear:year];
		[components setMonth:month];
		[components setDay:day];
		[components setHour:hour];
		[components setMinute:minute];
		return [calendar dateFromComponents:components];		
	}
	return nil;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

	 _debugSkipUpdates = NO;
	
    [GMSServices provideAPIKey:@"AIzaSyDU0vT2zWBngyt1OkT2HZsv_ZRPnP12gog"];

    self.window.backgroundColor = [UIColor whiteColor];

    [self setup_CoreData_Xml_Database_And_Server];
    [self getInitializationData];    

    [self setAppearance];

    [self startOnSplashScreen];
	
    [self.window makeKeyAndVisible];
	
	NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
	if (notification) {
		[_pmh notificationReceived:notification];
		return YES;
	}
    return YES;
}

-(void)setup_CoreData_Xml_Database_And_Server {
    _xml = [[RWXMLStore alloc] init];

    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) {
        NSLog(@"setup_CoreData_Xml_Database_And_Server: NSManagedObjectContext is nil");
    }

    _db = [[RWDbInterface alloc] initWithManagedObjectContext:context xml:_xml];
    _sv = [[RWServer alloc] initWithDatabase:_db datafilesfolderpath:_xml.dataFilesFolderPath];
	_pmh = [[RWPushMessageSubscriptionHandler alloc] init];
}

-(void)getInitializationData {
	_lastUpdated = [[NSDate alloc] init];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
	[_pmh receiveRegistrationId:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Error in registration. Error: %@", error);
}

- (void)setAppearance {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setTabBarAppearance];
}

- (void)setTabBarAppearance {

    RWXmlNode *globalLook = [_xml.appearance getChildFromNode:[RWLOOK DEFAULT]];
    RWXmlNode *localLook = [_xml.appearance getChildFromNode:[RWLOOK TABBAR]];

    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];

    if ([localLook hasChild:[RWLOOK TABBAR_BACKGROUNDIMAGE]]) {
        UIImage *tabBarBackground = [UIImage imageNamed:[localLook getStringFromNode:[RWLOOK TABBAR_BACKGROUNDIMAGE]]];
        [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    } else {
        UIColor *backgroundColor = [helper.getter getColorWithLocalName:[RWLOOK TABBAR_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BARCOLOR]];
        [[UITabBar appearance] setBackgroundColor:backgroundColor];
    }

    UIColor *tabbarTextColor = [helper.getter getColorWithLocalName:[RWLOOK TABBAR_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BARTEXTCOLOR]];
    UIFont *tabbarTextFont = [helper.getter getTextFontWithLocalSizeName:[RWLOOK TABBAR_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE] localStyleName:[RWLOOK TABBAR_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];

    NSMutableDictionary *tabbarAttributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            tabbarTextFont, NSFontAttributeName,
            tabbarTextColor, NSForegroundColorAttributeName,
            nil];

    NSShadow *tabbarTextShadow = [[NSShadow alloc] init];
    if([localLook hasChild:[RWLOOK TABBAR_TEXTSHADOWCOLOR]] || [globalLook hasChild:[RWLOOK DEFAULT_BARTEXTSHADOWCOLOR]])   {
        UIColor *tabbarShadowColor = [helper.getter getColorWithLocalName:[RWLOOK TABBAR_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BARTEXTSHADOWCOLOR]];
        [tabbarTextShadow setShadowColor:tabbarShadowColor];
    }
    if([localLook hasChild:[RWLOOK TABBAR_TEXTSHADOWOFFSET]] || [globalLook hasChild:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]])   {
        CGSize tabbarShadowOffset = [helper.getter getCGSizeWithLocalName:[RWLOOK TABBAR_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
        [tabbarTextShadow setShadowOffset:tabbarShadowOffset];
    }
    [tabbarAttributes setValue:tabbarTextShadow forKey:NSShadowAttributeName];

    [[UITabBarItem appearance] setTitleTextAttributes:tabbarAttributes forState:UIControlStateNormal];
}

//
// Splash Page Start

- (void)startOnSplashScreen {
    NSLog(@"Start on Splash Screen");
    RWSplashViewController *viewController = [[RWSplashViewController alloc] initWithNibName:@"RWSplashViewController" bundle:nil];
    self.window.rootViewController = viewController;
}

- (void)startNavController {
    _navController = [[RWNavigationController alloc] init];
	//Note that the navcontroller is not functional until it has connected to the mainView in the
	//RWMainViewController's onViewLoaded method
	
    RWMainViewController *mainView = [[RWMainViewController alloc] initWithStartPage:[_xml getPage:@"Autosubscriber"]];
	self.window.rootViewController = mainView;
}

//
// Notification Start

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification {
	[_pmh notificationReceived:notification];
}

- (void)errorOccured:(NSString *)errorMessage {

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Red_Event_App" ofType:@"momd"];
	NSURL *momURL = [NSURL fileURLWithPath:path];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
//    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Red_Event_App.sqlite"];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                                NSInferMappingModelAutomaticallyOption:@YES};
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
