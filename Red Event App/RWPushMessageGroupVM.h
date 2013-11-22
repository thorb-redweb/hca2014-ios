//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>

@class PushMessageGroup;
@class RWXMLStore;


@interface RWPushMessageGroupVM : NSObject

@property (strong, nonatomic) PushMessageGroup *pushMessageGroup;

- (id)initWithPushMessageGroup:(PushMessageGroup *)pushMessageGroup;

@end