//
//  RWPushMessageListCell.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/25/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWPushMessageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwContentView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBody;

@end
