//
//  RWRedUploadFolderContentItem.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseCollectionItem.h"

@interface RWRedUploadFolderContentItem : RWBaseCollectionItem

@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblText;

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource thumbnail:(UIImage *)thumbnail;

@end
