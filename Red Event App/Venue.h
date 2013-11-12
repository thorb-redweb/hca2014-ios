//
//  Venue.h
//  Jule App
//
//  Created by Thorbjørn Steen on 10/29/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Session;

@interface Venue : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * latitude;
@property (nonatomic, retain) NSDecimalNumber * longitude;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * venueid;
@property (nonatomic, retain) NSString * descript;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * imagepath;
@property (nonatomic, retain) NSSet *sessions;
@end

@interface Venue (CoreDataGeneratedAccessors)

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end
