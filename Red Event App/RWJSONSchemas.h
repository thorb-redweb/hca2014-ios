//
// Created by Thorbjørn Steen on 11/18/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>
@class RWJSONArticle;
@class RWJSONEvent;
@class RWJSONPushMessage;
@class RWJSONPushMessageGroup;
@class RWJSONSession;
@class  RWJSONVenue;

@interface RWJSONSchemas : NSObject
-(RWJSONArticle *)Art;
-(RWJSONEvent *)Event;
-(RWJSONPushMessage *)Push;
-(RWJSONPushMessageGroup *)PushGroup;
-(RWJSONSession *)Ses;
-(RWJSONVenue *)Venue;
@end