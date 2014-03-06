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
@property(nonatomic, weak) IBOutlet UILabel *lblType;
@property(nonatomic, weak) IBOutlet UIImageView *imgType;
@property(nonatomic, weak) IBOutlet UIView *vwRightBorder;

@end
