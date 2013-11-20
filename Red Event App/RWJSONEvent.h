//
// Created by Thorbjørn Steen on 11/18/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface RWJSONEvent : NSObject
- (NSString *)EVENT_ID;

- (NSString *)TITLE;

- (NSString *)SUMMARY;

- (NSString *)DETAILS;

- (NSString *)SUBMISSION;

- (NSString *)IMAGEPATH;

- (NSString *)ITEMTYPE;

- (NSString *)ACTIONTYPE;
@end