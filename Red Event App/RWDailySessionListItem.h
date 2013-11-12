//
//  RWDailySessionListItem.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWDailySessionListItem : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *lblTimeAndPlace;
@property(nonatomic, weak) IBOutlet UILabel *lblEvent;

@end
