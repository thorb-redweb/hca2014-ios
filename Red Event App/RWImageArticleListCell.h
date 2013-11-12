//
//  RWImageContentCell.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWArticleVM.h"
#import "RWHandler_GetImage.h"

@interface RWImageArticleListCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *lblTitle;
@property(nonatomic, weak) IBOutlet UILabel *lblIntro;
@property(nonatomic, weak) IBOutlet UIImageView *imgThumb;

@property(strong, nonatomic) RWArticleVM *model;

@end
