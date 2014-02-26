//
//  RWHcaListCell.h
//  Red App
//
//  Created by Thorbjørn Steen on 2/25/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWBaseListItem.h"

@interface RWHcaListCell : RWBaseListItem

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgArticle;
@property (weak, nonatomic) IBOutlet UIView *vwRightBorder;

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource;

@end
