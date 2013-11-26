//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import "RWPushMessageVM.h"
#import "PushMessage.h"
#import "RWXMLStore.h"


@implementation RWPushMessageVM {
}

-(id)initWithPushMessage:(PushMessage *)pushMessage{
    if(self = [super init]){
        _pushMessage = pushMessage;
    }
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"RWPushMessageVM: \npushmessageid: %@ \ngroupid: %@ \nauthor: %@ \nintro: %@ \nmessage: %@ \nsenddate: %@",
                    _pushMessage.pushmessageid, _pushMessage.groupid, _pushMessage.author, _pushMessage.intro, _pushMessage.message, _pushMessage.senddate];
    return description;
}

-(NSNumber *)pushmessageid{
    return _pushMessage.pushmessageid;
}

-(NSNumber *)groupid{
    return _pushMessage.groupid;
}

-(NSString *)author{
    return _pushMessage.author;
}

-(NSString *)intro{
    return _pushMessage.intro;
}

-(NSString *)message{
    return _pushMessage.message;
}

-(NSString *)senddateWithPattern:(NSString *)pattern{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:pattern];
    return [dateFormatter stringFromDate:_pushMessage.senddate];
}

@end