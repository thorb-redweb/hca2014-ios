//
//  RWRedUploadFolderContentViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RWBaseViewController.h"

@interface RWRedUploadFolderContentViewController : RWBaseViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *lstImages;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIView *vwTakePicture;
@property (weak, nonatomic) IBOutlet UIView *vwFrontBox;
@property (weak, nonatomic) IBOutlet UILabel *lblTakePicture;
@property (weak, nonatomic) IBOutlet UIImageView *imgTakePicture;

@property (weak, nonatomic) IBOutlet UIButton *btnUpload;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

- (id)initWithPage:(RWXmlNode *)page;

@end
