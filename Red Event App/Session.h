//
//  Session.h
//  Jule App
//
//  Created by Thorbjørn Steen on 10/29/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, Venue;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSDate * enddatetime;
@property (nonatomic, retain) NSNumber * eventid;
@property (nonatomic, retain) NSNumber * sessionid;
@property (nonatomic, retain) NSDate * startdatetime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * venueid;
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) Venue *venue;

@end
