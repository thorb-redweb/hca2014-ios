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

@implementation RWPushMessageSubscriptionHandler


-(void)subscribeToPushMessages{
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound)];
}

-(void)receiveRegistrationId:(NSData *)deviceToken{

    RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
	[app.sv sendProviderDeviceToken:deviceToken];
	DDLogDebug(@"My token is: %@", deviceToken);
}

@end
