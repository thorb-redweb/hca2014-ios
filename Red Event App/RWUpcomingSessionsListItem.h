//
//  RWUpcomingSessionsListItem.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/8/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWUpcomingSessionsListItem : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblDateTime;
@property(nonatomic, weak) IBOutlet UILabel *lblEventAndPlace;
@end
