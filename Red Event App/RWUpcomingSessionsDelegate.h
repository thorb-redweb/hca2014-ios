//
//  RWUpcomingSessionsDelegate.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWNode;

@interface RWUpcomingSessionsDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

- (id)initWithPage:(RWNode *)page;

@end
