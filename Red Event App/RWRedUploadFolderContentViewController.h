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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (id)initWithPage:(RWXmlNode *)page;

@end
