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

#import "RWVolatileDataStores.h"
#import "RWRedUploadDataStore.h"
#import "RWRedUploadServerFolder.h"

#import "RWDbRedUploadImages.h"

#import "RWXmlNode.h"

@interface RWRedUploadFolderContentViewController ()

@end

@implementation RWRedUploadFolderContentViewController{
	RWRedUploadServerFolder *_folder;
	NSMutableArray *_dataSource;
	NSMutableDictionary *_thumbnails;
	
	NSMutableArray *_selectedItems;
}

- (id)initWithPage:(RWXmlNode *)page{
	if(self = [super initWithNibName:@"RWRedUploadFolderContentViewController" bundle:Nil page:page]){
		_selectedItems = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];	
    
	[self setValues];
	[self setControls];
}

- (void)setValues{
	int folderId = [_page getIntegerFromNode:[RWPAGE REDUPLOADFOLDERID]];
	_folder = [[_app.volatileDataStores getRedUpload] getFolder:folderId];
}

- (void)setControls{
	UINib *cellNib = [UINib nibWithNibName:@"RWRedUploadFolderContentItem" bundle:nil];
	[_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ImageCell"];
	_collectionView.allowsMultipleSelection = YES;
	
	//If no items are selected from start, the Upload and Edit buttons should start disabled
	_btnUpload.enabled = NO;
	_btnEdit.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	_dataSource = [_db.RedUploadImages getFromServerFolder:_folder.serverFolder];
	_thumbnails = [[NSMutableDictionary alloc] init];
    
	[_collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)getThumbnailForRow:(int)row{
	NSString *nrow = [NSString stringWithFormat:@"%d",row];
	UIImage *thumbnail = [_thumbnails objectForKey:nrow];
	if(thumbnail){
		return thumbnail;
	}
	
	RedUploadImage *redUploadImage = _dataSource[row];
	
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
	
	[_thumbnails setValue:thumbnail forKey:nrow];
	return thumbnail;
}

#pragma mark UICollection Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	RWRedUploadFolderContentItem *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWRedUploadFolderContentItem" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
	
	if(cell.selected){
		cell.backgroundColor = [UIColor redColor];
	}
	else {
		cell.backgroundColor = [UIColor whiteColor];
	}
	
	int row = indexPath.row;
	UIImage *thumbnail = [self getThumbnailForRow:row];
	
	[cell setupCellWithRow:row dataSource:_dataSource thumbnail:thumbnail];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *datasetCell = [cv cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor redColor];
	
	[_selectedItems addObject:_dataSource[indexPath.row]];
	
	if(_selectedItems.count == 1){
		_btnEdit.enabled = YES;
		_btnUpload.enabled = YES;
	}
	else { //More than one item selected
		_btnEdit.enabled = NO;
	}
}

- (void)collectionView:(UICollectionView *)cv didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *datasetCell =[cv cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor whiteColor];
	
    [_selectedItems removeObject:_dataSource[indexPath.row]];
	
	if(_selectedItems.count == 0){
		_btnEdit.enabled = NO;
		_btnUpload.enabled = NO;
	}
	else if(_selectedItems.count == 1){
		_btnEdit.enabled = YES;
	}
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(150, 250);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - Button Actions

-(IBAction)backButtonClicked:(id)sender{
	[_app.navController popPage];
}

-(IBAction)pictureButtonClicked:(id)sender{
	RWXmlNode *cameraPage = [[_xml getPage:[_page getStringFromNode:[RWPAGE CHILD]]] deepClone];
	
	[cameraPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
	
	[_app.navController pushViewWithPage:cameraPage];
}

-(IBAction)uploadButtonClicked:(id)sender{
	
}

-(IBAction)editButtonClicked:(id)sender{
	RedUploadImage *redUploadImageObject = _selectedItems[0];
	
	RWXmlNode *childPage = [[_xml getPage:[_page getStringFromNode:[RWPAGE CHILD]]] deepClone];
	
	[childPage addNodeWithName:[RWPAGE FILEPATH] value:redUploadImageObject.localimagepath];
	[childPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
	
	[_app.navController pushViewWithPage:childPage];
}

@end
