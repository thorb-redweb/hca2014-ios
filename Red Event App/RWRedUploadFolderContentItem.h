//
//  RWRedUploadFolderContentItem.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseCollectionItem.h"
#import "RedUploadImage.h"

@interface RWRedUploadFolderContentItem : RWBaseCollectionItem

@property (weak, nonatomic) IBOutlet UIView *vwTopArea;
@property (weak, nonatomic) IBOutlet UIView *vwApprovedTag;
@property (weak, nonatomic) IBOutlet UIView *vwBottomArea;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;
@property (weak, nonatomic) IBOutlet UILabel *lblText;

@property (strong, nonatomic) RedUploadImage *redUploadImageObject;

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource thumbnail:(UIImage *)thumbnail;

- (void) setSelected;
- (void) setDeSelected;

@end
