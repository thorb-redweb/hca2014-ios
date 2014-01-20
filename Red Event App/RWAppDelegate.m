//
//  RWAppDelegate.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIColor+RWColor.h"
#import <GoogleMaps/GoogleMaps.h>
#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import "MyLog.h"

#import "RWAppDelegate.h"

#import "RWSplashViewController.h"
#import "RWMainViewController.h"

#import "RWRedUploadDataStore.h"

#import "RWAppearanceHelper.h"
#import "RWPAGE.h"
#import "RWVolatileDataStores.h"

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

	 _debugSkipUpdates = NO;
	
    [GMSServices provideAPIKey:@"AIzaSyCpSOR5gXO1zDC3B5uRnpek-oRt4e9nF3Q"];

    self.window.backgroundColor = [UIColor whiteColor];

    [self setup_CoreData_Xml_Database_And_Server];
	[self setup_Lumberjack];
    [self getInitializationData];    

    [self setAppearance];

    [self startOnSplashScreen];

    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setup_CoreData_Xml_Database_And_Server {
    _xml = [[RWXMLStore alloc] init];

    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) {
        DDLogWarn(@"setup_CoreData_Xml_Database_And_Server: NSManagedObjectContext is nil");
    }

    _db = [[RWDbInterface alloc] initWithManagedObjectContext:context xml:_xml];
    _sv = [[RWServer alloc] initWithDatabase:_db datafilesfolderpath:_xml.dataFilesFolderPath];
	_pmh = [[RWPushMessageSubscriptionHandler alloc] init];
}

-(void)setup_Lumberjack{
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
	fileLogger.rollingFrequency = 60 * 60 * 24;
	fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
	fileLogger.maximumFileSize = 384 * 1024;
	[fileLogger setLogFormatter:[[DDLogFileFormatterDefault alloc] init]];
	[DDLog addLogger:fileLogger];
	
	[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

-(void)getInitializationData {
	_volatileDataStores = [[RWVolatileDataStores alloc] init];
	if([_xml.pages hasChild:[RWPAGE GLOBAL]]){
		RWXmlNode *global = [_xml.pages getChildFromNode:[RWPAGE GLOBAL]];
		if([global hasChild:[RWPAGE USEREDUPLOAD]] && [global getBoolFromNode:[RWPAGE USEREDUPLOAD]]){
			[_volatileDataStores addObject:[[RWRedUploadDataStore alloc] initWithDb:_db]];
		}
	}
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
	[_pmh receiveRegistrationId:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    DDLogError(@"Error in registration. Error: %@", error);
}

- (void)setAppearance {

    [self setNavigationBarAppearance];
    [self setTabBarAppearance];
}

- (void)setNavigationBarAppearance {
    RWXmlNode *globalLook = [_xml.appearance getChildFromNode:[RWLOOK DEFAULT]];
    RWXmlNode *localLook = [_xml.appearance getChildFromNode:[RWLOOK NAVIGATIONBAR]];
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];

    if ([localLook hasChild:[RWLOOK NAVBAR_BACKGROUNDIMAGE]]) {
        UIImage *navBarBackground = [UIImage imageNamed:[localLook getStringFromNode:[RWLOOK NAVBAR_BACKGROUNDIMAGE]]];
        [[UINavigationBar appearance] setBackgroundImage:navBarBackground forBarMetrics:UIBarMetricsDefault];
    } else {
        UIColor *backgroundColor = [helper.getter getColorWithLocalName:[RWLOOK NAVBAR_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BARCOLOR]];
        [[UINavigationBar appearance] setBarTintColor:backgroundColor];
    }

    //Title
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];

    UIColor *titleColor = [helper.getter getColorWithLocalName:[RWLOOK NAVBAR_TITLECOLOR] globalName:[RWLOOK DEFAULT_BARTEXTCOLOR]];
    [titleBarAttributes setValue:titleColor forKey:NSForegroundColorAttributeName];

    UIFont *titleFont = [helper.getter getTextFontWithLocalSizeName:[RWLOOK NAVBAR_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
                                              localStyleName:[RWLOOK NAVBAR_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
    [titleBarAttributes setValue:titleFont forKey:NSFontAttributeName];

    NSShadow *titleShadow = [[NSShadow alloc] init];
    if([localLook hasChild:[RWLOOK NAVBAR_TITLESHADOWCOLOR]] || [globalLook hasChild:[RWLOOK DEFAULT_BARTEXTSHADOWCOLOR]])   {
        UIColor *titleShadowColor = [helper.getter getColorWithLocalName:[RWLOOK NAVBAR_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BARTEXTSHADOWCOLOR]];
        [titleShadow setShadowColor:titleShadowColor];

    }
    if([localLook hasChild:[RWLOOK NAVBAR_TITLESHADOWOFFSET]] || [globalLook hasChild:[RWLOOK DEFAULT_TITLESHADOWOFFSET]])   {
        CGSize titleShadowOffset = [helper.getter getCGSizeWithLocalName:[RWLOOK NAVBAR_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];
        [titleShadow setShadowOffset:titleShadowOffset];
    }
    [titleBarAttributes setValue:titleShadow forKey:NSShadowAttributeName];

    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];

    //Backbutton
    if([localLook hasChild:[RWLOOK NAVBAR_UPBUTTONBACKIMAGE]]){
        NSString *imageName = [localLook getStringFromNode:[RWLOOK NAVBAR_UPBUTTONBACKIMAGE]];
        UIImage *backButtonImage = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
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
	DDLogVerbose(@"Start on Splash Screen");
    RWSplashViewController *viewController = [[RWSplashViewController alloc] initWithNibName:@"RWSplashViewController" bundle:nil];
    self.window.rootViewController = viewController;
}

- (void)startNavController {
    _navController = [[RWNavigationController alloc] init];
	//Note that the navcontroller is not functional until it has connected to the mainView in the
	//RWMainViewController's onViewLoaded method
	
    RWMainViewController *mainView = [[RWMainViewController alloc] initWithStartPage:[_xml getFrontPage]];
	self.window.rootViewController = mainView;
}

//
// Notification Start

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification {
    DDLogInfo(@"Push message received, start data update");
	_localNotification = notification;
    [self checkForUpdates];
}

- (void)checkForUpdates {
    [_sv updateDatabase:self];
}

- (void)continueAfterUpdate {
    DDLogVerbose(@"Continue after update");
    //Start by adding the frontpage
    _navController = [[RWNavigationController alloc] init];
    RWMainViewController *mainView = [[RWMainViewController alloc] initWithStartPage:[_xml getFrontPage]];
    self.window.rootViewController = mainView;

    //And then push the push message page on to the stack
    NSString *messageid = _localNotification[@"content"][@"messageid"];
    RWXmlNode *nextPage = [_xml getPage:@"Nyhedsside"];
    [nextPage addNodeWithName:[RWPAGE ARTICLEID] value:messageid];

    [_navController pushViewWithPage:nextPage];
    DDLogInfo(@"Show push message content");
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
            DDLogError(@"Unresolved error %@, %@", error, [error userInfo]);
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
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
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
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
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
        DDLogError(@"Unresolved error %@, %@", error, [error userInfo]);
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
