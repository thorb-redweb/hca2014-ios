//
//  PushMessageGroup.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PushMessage;

@interface PushMessageGroup : NSManagedObject

@property (nonatomic, retain) NSNumber * groupid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * subscribing;
@property (nonatomic, retain) NSSet *pushmessages;
@end

@interface PushMessageGroup (CoreDataGeneratedAccessors)

- (void)addPushmessagesObject:(PushMessage *)value;
- (void)removePushmessagesObject:(PushMessage *)value;
- (void)addPushmessages:(NSSet *)values;
- (void)removePushmessages:(NSSet *)values;

@end
