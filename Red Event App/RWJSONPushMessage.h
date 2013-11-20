//
// Created by Thorbjørn Steen on 11/18/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface RWJSONPushMessage : NSObject
- (NSString *)PUSHMESSAGE_ID;

- (NSString *)GROUP_ID;

- (NSString *)INTRO;

- (NSString *)MESSAGE;

- (NSString *)AUTHOR;

- (NSString *)SENDDATE;

- (NSString *)ITEMTYPE;

- (NSString *)ACTIONTYPE;
@end