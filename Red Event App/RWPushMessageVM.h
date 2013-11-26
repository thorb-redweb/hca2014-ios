//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>

@class PushMessage;
@class RWXMLStore;


@interface RWPushMessageVM : NSObject

@property (strong, nonatomic) PushMessage *pushMessage;

- (id)initWithPushMessage:(PushMessage *)pushMessage;

- (NSNumber *)pushmessageid;

- (NSNumber *)groupid;

- (NSString *)author;

- (NSString *)intro;

- (NSString *)message;

- (NSString *)senddateWithPattern:(NSString *)pattern;
@end