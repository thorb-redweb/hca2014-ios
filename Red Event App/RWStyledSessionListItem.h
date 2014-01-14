//
//  RWStyledSessionListItem.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/13/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RWBaseListItem.h"

@interface RWStyledSessionListItem : RWBaseListItem

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBody;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePicture;
@property (weak, nonatomic) IBOutlet UIButton *btnSeeArchive;
@property (weak, nonatomic) IBOutlet UIView *vwSeperator;

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource;

@end
