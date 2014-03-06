//
//  RWPushMessageSubscriptionHandler.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWPushMessageSubscriptionHandler.h"
#import "RWAppDelegate.h"
#import "RWServer.h"
#import "RWXMLStore.h"
#import "RWMainViewController.h"

@implementation RWPushMessageSubscriptionHandler{
	RWAppDelegate *_app;
	RWServer *_sv;
	RWXMLStore *_xml;
	
	NSDictionary *_currentNotification;
}

-(id)init{
	if(self = [super init]){
		_app = [[UIApplication sharedApplication] delegate];
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
	DDLogDebug(@"My token is: %@", deviceToken);
}

-(void)notificationReceived:(NSDictionary *)notification{
	UIApplication *application = [UIApplication sharedApplication];
	
	//Check whether or not the application is already active, and proceed from there
	if(application.applicationState == UIApplicationStateActive){
		DDLogInfo(@"Push message received, no action");
	}
	else{
		//if not active, get updates. The delegate will continue to continueAfterUpdate
		DDLogInfo(@"Push message received, start data update");
		_currentNotification = notification;
		[_sv updateDatabase:self];
	}
}

- (void)continueAfterUpdate {
    DDLogVerbose(@"Continue after update");
	_app.navController = [[RWNavigationController alloc] init];
	//Note that the navcontroller is not functional until it has connected to the mainView in the
	//RWMainViewController's onViewLoaded method
	
    NSString *messageid = _currentNotification[@"content"][@"messageid"];
	RWXmlNode *nextPage = [[_xml getPage:@"Nyhedsside"] deepClone];
	[nextPage addNodeWithName:[RWPAGE ARTICLEID] value:messageid];
	
	RWMainViewController *mainView = [[RWMainViewController alloc] initWithStartPage:nextPage];
	_app.window.rootViewController = mainView;
    DDLogInfo(@"Starting on page with push message content");
}


- (void)errorOccured:(NSString *)errorMessage {
	
}

@end
