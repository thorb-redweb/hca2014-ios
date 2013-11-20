//
//  RWTableNavigatorCell.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/20/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWTableNavigatorCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UIImageView *imgFrontIcon;
@property(nonatomic, weak) IBOutlet UILabel *lblTitle;
@property(nonatomic, weak) IBOutlet UIImageView *imgBackIcon;

@end
