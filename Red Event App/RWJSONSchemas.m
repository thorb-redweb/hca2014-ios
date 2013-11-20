//
// Created by Thorbjørn Steen on 11/18/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import "RWJSONSchemas.h"
#import "RWJSONArticle.h"
#import "RWJSONEvent.h"
#import "RWJSONPushMessage.h"
#import "RWJSONPushMessageGroup.h"
#import "RWJSONSession.h"
#import "RWJSONVenue.h"

@implementation RWJSONSchemas {
    RWJSONArticle *_article;
    RWJSONEvent *_event;
    RWJSONPushMessage *_pushMessage;
    RWJSONPushMessageGroup *_pushMessageGroup;
    RWJSONSession *_session;
    RWJSONVenue *_venue;
}

-(id)init{
    if(self = [super init]){
        _article = [[RWJSONArticle alloc] init];
        _event = [[RWJSONEvent alloc] init];
        _pushMessage = [[RWJSONPushMessage alloc] init];
        _pushMessageGroup = [[RWJSONPushMessageGroup alloc] init];
        _session = [[RWJSONSession alloc] init];
        _venue = [[RWJSONVenue alloc] init];
    }
    return self;
}

-(RWJSONArticle *)Art{ return _article; }
-(RWJSONEvent *)Event{ return _event; }
-(RWJSONPushMessage *)Push{ return _pushMessage; }
-(RWJSONPushMessageGroup *)PushGroup{ return _pushMessageGroup; }
-(RWJSONSession *)Ses{ return _session; }
-(RWJSONVenue *)Venue{ return _venue; }
@end