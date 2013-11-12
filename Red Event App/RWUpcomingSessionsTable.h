//
//  RWUpcomingSessions.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWUpcomingSessionsDelegate.h"

#import "RWNode.h"
#import "RWLOOK.h"
#import "RWPAGE.h"

@interface RWUpcomingSessionsTable : UITableView

- (id)initWithFrame:(CGRect)frame subviewElement:(RWNode *)page;

@end
