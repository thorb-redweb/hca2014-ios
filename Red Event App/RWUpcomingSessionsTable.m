//
//  RWUpcomingSessions.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWUpcomingSessionsTable.h"

@implementation RWUpcomingSessionsTable {
    RWUpcomingSessionsDelegate *delegate;
}

- (id)initWithFrame:(CGRect)frame subviewElement:(RWXmlNode *)page {
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        // Initialization code
        delegate = [[RWUpcomingSessionsDelegate alloc] initWithPage:page];
        self.delegate = delegate;
        self.dataSource = delegate;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
