//
//  RWPushMessageSubscriptionHandler.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "CRToast.h"

#import "RWPushMessageSubscriptionHandler.h"
#import "RWAppDelegate.h"
#import "RWDbArticles.h"
#import "RWMainViewController.h"
#import "RWArticleVM.h"

@implementation RWPushMessageSubscriptionHandler{
	RWAppDelegate *_app;
	RWDbInterface *_db;
	RWServer *_sv;
	RWXMLStore *_xml;
	
	NSDictionary *_currentNotification;
}

-(id)init{
	if(self = [super init]){
		_app = [[UIApplication sharedApplication] delegate];
		_db = _app.db;
		_sv = _app.sv;
		_xml = _app.xml;
	}
	return self;
}

-(void)subscribeToPushMessages{
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound)];
}

-(void)receiveRegistrationId:(NSData *)deviceToken{

    RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
	[app.sv sendProviderDeviceToken:deviceToken];
    NSLog(@"My token is: %@", deviceToken);
}

-(void)notificationReceived:(NSDictionary *)notification{
    NSLog(@"Push message received, start data update");
	[_sv updateDatabase:self];
	_currentNotification = notification;
}

- (void)continueAfterUpdate {
    NSLog(@"Continue after update");
	
	//Check whether or not the application is already active, and act accordingly
	UIApplication *application = [UIApplication sharedApplication];
	if(application.applicationState == UIApplicationStateActive){
		//if the application is active, we'll simply show a toast
        NSLog(@"Push message received, show toast");
		
		RWArticleVM *article = [_db.Articles getVMFromId:[_currentNotification[@"content"][@"messageid"] intValue]];
		
		NSMutableDictionary *options;
		options = [@{kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
					 kCRToastNotificationPresentationTypeKey : @(CRToastPresentationTypeCover),
					 kCRToastUnderStatusBarKey : @(YES),
					 kCRToastBackgroundColorKey : [UIColor blackColor],
					 kCRToastTimeIntervalKey : @(3),
					 kCRToastTextKey : @"Nyhed modtaget",
					 kCRToastTextAlignmentKey : @(1),
					 kCRToastTextColorKey : [UIColor whiteColor],
					 kCRToastSubtitleTextKey : [article title],
					 kCRToastSubtitleTextAlignmentKey : @(1),
					 kCRToastSubtitleTextColorKey : [UIColor whiteColor],
					 kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
					 kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
					 kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
					 kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight)
					 } mutableCopy];
		[CRToastManager showNotificationWithOptions:options completionBlock:^{}];
	}
	else{
		//if the applocation was not active, we'll start up the nav controller and so on
		_app.navController = [[RWNavigationController alloc] init];
		//Note that the navcontroller is not functional until it has connected to the mainView in the
		//RWMainViewController's onViewLoaded method
		
		NSString *messageid = _currentNotification[@"content"][@"messageid"];
		RWXmlNode *nextPage = [[_xml getPage:@"Nyhedsside"] deepClone];
		[nextPage addNodeWithName:[RWPAGE ARTICLEID] value:messageid];
		
		RWMainViewController *mainView = [[RWMainViewController alloc] initWithStartPage:nextPage];
		_app.window.rootViewController = mainView;
        NSLog(@"Starting on page with push message content");
	}
}


- (void)errorOccured:(NSString *)errorMessage {
	
}

@end
