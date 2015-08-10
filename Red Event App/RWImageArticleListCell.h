//
//  RWImageContentCell.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWArticleVM.h"

@interface RWImageArticleListCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *lblTitle;
@property(nonatomic, weak) IBOutlet UILabel *lblIntro;
@property(nonatomic, weak) IBOutlet UILabel *lblDate;
@property(nonatomic, weak) IBOutlet UIImageView *imgThumb;
@property(nonatomic, weak) IBOutlet UIView *vwContentView;

@end
