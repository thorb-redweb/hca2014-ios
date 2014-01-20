//
//  RWRedUploadOtherFolderListItem.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/17/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseListItem.h"

@interface RWRedUploadOtherFolderListItem : RWBaseListItem

@property (weak, nonatomic) IBOutlet UIView *vwBox;
@property (weak, nonatomic) IBOutlet UILabel *lblBody;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePicture;
@property (weak, nonatomic) IBOutlet UIButton *btnSeeArchive;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource;

@end
