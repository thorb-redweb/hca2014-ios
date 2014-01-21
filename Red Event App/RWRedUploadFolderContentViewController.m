//
//  RWRedUploadFolderContentViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadFolderContentViewController.h"
#import "RWRedUploadFolderContentItem.h"
#import "RedUploadImage.h"

#import "RWDbRedUploadImages.h"

#import "RWXmlNode.h"

@interface RWRedUploadFolderContentViewController ()

@end

@implementation RWRedUploadFolderContentViewController{
	NSMutableArray *dataSource;
	NSMutableDictionary *thumbnails;
}

- (id)initWithPage:(RWXmlNode *)page{
	if(self = [super initWithNibName:@"RWRedUploadFolderContentViewController" bundle:Nil page:page]){
		
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	dataSource = [_db.RedUploadImages getAll];
	thumbnails = [[NSMutableDictionary alloc] init];
    
	UINib *cellNib = [UINib nibWithNibName:@"RWRedUploadFolderContentItem" bundle:nil];
	[_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ImageCell"];
	[_collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)getThumbnailForRow:(int)row{
	NSString *nrow = [NSString stringWithFormat:@"%d",row];
	UIImage *thumbnail = [thumbnails objectForKey:nrow];
	if(thumbnail){
		return thumbnail;
	}
	
	RedUploadImage *redUploadImage = dataSource[row];
	
	UIImage *originalImage = [UIImage imageWithContentsOfFile:redUploadImage.localimagepath];
	CGSize originalSize = originalImage.size;
	CGSize destinationSize;
	if(originalSize.height > originalSize.width){
		destinationSize = CGSizeMake(100 * originalSize.width / originalSize.height, 100);
	}
	else {
		destinationSize = CGSizeMake(100, 100 * originalSize.height / originalSize.width);
	}
	
	UIGraphicsBeginImageContext(destinationSize);
	[originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
	thumbnail = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	[thumbnails setValue:thumbnail forKey:nrow];
	return thumbnail;
}

#pragma mark UICollection Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	RWRedUploadFolderContentItem *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWRedUploadFolderContentItem" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
	
	int row = indexPath.row;
	UIImage *thumbnail = [self getThumbnailForRow:row];
	
	[cell setupCellWithRow:row dataSource:dataSource thumbnail:thumbnail];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(150, 250);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
