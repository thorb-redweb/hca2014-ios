//
// Created by Thorbjørn Steen on 11/22/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import "RWPushMessageGroupVM.h"
#import "PushMessageGroup.h"
#import "RWXMLStore.h"


@implementation RWPushMessageGroupVM {

}

- (id)initWithPushMessageGroup:(PushMessageGroup *)pushMessageGroup{
    if(self = [super init]){
        _pushMessageGroup = pushMessageGroup;
    }
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"RWPushMessageGroupVM: \ngroupid: %@ \nname: %@ \nsubscribing: %@", _pushMessageGroup.groupid, _pushMessageGroup.name, _pushMessageGroup.subscribing];
    return description;
}

-(NSNumber *)groupid{
    return _pushMessageGroup.groupid;
}

-(NSString *)name{
    return _pushMessageGroup.name;
}

-(bool)subscribing{
    return _pushMessageGroup.subscribing;
}

@end