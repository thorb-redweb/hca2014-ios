//
//  RWPushMessageSubscriptionHandler.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWPushMessageSubscriptionDelegate <NSObject>

@required
-(void)receiveRegistrationId:(NSString *)regid;
@end

@interface RWPushMessageSubscriptionHandler : NSObject <RWPushMessageSubscriptionDelegate>
-(void)subscribeToPushMessages;
-(void)receiveRegistrationId:(NSData *)deviceToken;
@end
