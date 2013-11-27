//
//  PushMessage.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PushMessageGroup;

@interface PushMessage : NSManagedObject

@property (nonatomic, retain) NSNumber * pushmessageid;
@property (nonatomic, retain) NSNumber * groupid;
@property (nonatomic, retain) NSString * intro;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSDate * senddate;
@property (nonatomic, retain) PushMessageGroup *group;

@end
