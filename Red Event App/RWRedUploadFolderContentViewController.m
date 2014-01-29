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
		
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];	
    
	[self setValues];
	[self setControls];
	[self setAppearance];
	[self setText];
}

- (void)setValues{
	int folderId = [_page getIntegerFromNode:[RWPAGE REDUPLOADFOLDERID]];
	_folder = [[_app.volatileDataStores getRedUpload] getFolder:folderId];
}

- (void)setControls{
	UINib *cellNib = [UINib nibWithNibName:@"RWRedUploadFolderContentItem" bundle:nil];
	[_lstImages registerNib:cellNib forCellWithReuseIdentifier:@"ImageCell"];
	_lstImages.allowsMultipleSelection = YES;
	
	[_vwTakePicture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureButtonClicked:)]];
	
	[self setButtonStates];
}

- (void)setAppearance{
	RWAppearanceHelper *helper = _appearanceHelper;
	
	[helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[helper setBackgroundColor:_lstImages localName:nil globalName:[RWLOOK INVISIBLE]];
	
	[helper.button setCustomStyle:_btnBack tag:@"topbutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper setBackgroundAsShape:_btnBack localBackgroundColorName:@"topbuttonbackgroundcolor" globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:1 localBorderColorName:@"topbuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	
	[helper setBackgroundColor:_vwTakePicture localName:nil globalName:[RWLOOK INVISIBLE]];
	[helper setBackgroundAsShape:_vwFrontBox localBackgroundColorName:@"topbuttonbackgroundcolor" globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:1 localBorderColorName:@"topbuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	[helper.label setColor:_lblTakePicture localName:@"topbuttontextcolor" globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
	[helper.label setFont:_lblTakePicture localSizeName:@"topbuttontextsize" globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:@"topbuttontextstyle" globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper.label setShadowColor:_lblTakePicture localName:@"topbuttontextshadowcolor" globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
	[helper.label setShadowOffset:_lblTakePicture localName:@"topbuttontextshadowoffset" globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	[helper setBackgroundColor:_imgTakePicture localName:@"camerabuttoniconcolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	[_imgTakePicture setImage:[_appearanceHelper.getter getImageFromLocalSourceWithLocalName:@"camerabuttonicon"]];

	[helper.label setTitleStyle:_lblTitle];
	
	[helper.button setCustomStyle:_btnUpload tag:@"uploadbutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper.button setDisabledTitleColor:_btnUpload localName:nil globalName:[RWLOOK DARKGREY]];
	[helper setBackgroundAsShapeWithGradiant:_btnUpload localBackgroundColorName1:@"uploadbuttonbackgroundcolor" globalBackgroundColorName1:[RWLOOK DEFAULT_BACKCOLOR]
					localBackgroundColorName2:@"uploadbuttonbackgroundcolor2" globalBackgroundColorName2:[RWLOOK DEFAULT_BACKCOLOR]
					 borderWidth:1 localBorderColorName:@"uploadbuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
		
	[helper.button setCustomStyle:_btnEdit tag:@"editbutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper.button setDisabledTitleColor:_btnEdit localName:nil globalName:[RWLOOK DARKGREY]];
	[helper setBackgroundAsShapeWithGradiant:_btnEdit localBackgroundColorName1:@"editbuttonbackgroundcolor" globalBackgroundColorName1:[RWLOOK DEFAULT_BACKCOLOR]
					localBackgroundColorName2:@"editbuttonbackgroundcolor2" globalBackgroundColorName2:[RWLOOK DEFAULT_BACKCOLOR]
					 borderWidth:1 localBorderColorName:@"editbuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
}

- (void)setText{
	RWTextHelper *helper = _textHelper;
	[helper setButtonText:_btnBack textName:[RWTEXT REDUPLOAD_BACKBUTTON] defaultText:[RWDEFAULTTEXT REDUPLOAD_BACKBUTTON]];
	[helper setText:_lblTakePicture textName:[RWTEXT REDUPLOAD_TOPRIGHTBUTTON] defaultText:[RWDEFAULTTEXT REDUPLOAD_TOPRIGHTBUTTON]];
	[helper setText:_lblTitle textName:@"title" defaultText:@"title"];
	[helper setButtonText:_btnUpload textName:@"uploadbutton" defaultText:@"uploadbutton"];
	[helper setButtonText:_btnEdit textName:@"editbutton" defaultText:@"editbutton"];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	_dataSource = [_db.RedUploadImages getFromServerFolder:_folder.serverFolder];
	_thumbnails = [[NSMutableDictionary alloc] init];
	for (NSIndexPath *indexPath in [_lstImages indexPathsForVisibleItems]) {
		[((RWRedUploadFolderContentItem *)[_lstImages cellForItemAtIndexPath:indexPath]) setDeSelected];
	}
	_selectedItems = [[NSMutableArray alloc] init];
	[self setButtonStates];
	
	[_lstImages reloadData];	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	if (_dataSource.count == 0) {
		[_app.navController popPage];
	}
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
	destinationSize = CGSizeMake(150 * originalSize.width / originalSize.height, 150);
	
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
	
	int row = indexPath.row;
	UIImage *thumbnail = [self getThumbnailForRow:row];
	RWXmlNode *itemPage = [_page deepClone];
	if([_selectedItems containsObject:_dataSource[row]]){
		[itemPage addNodeWithName:@"selected" value:@"YES"];
	}
	
	[cell initializeCellWithParentPage:itemPage];
	[cell setupCellWithRow:row dataSource:_dataSource thumbnail:thumbnail];
	
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	RWRedUploadFolderContentItem *datasetCell = (RWRedUploadFolderContentItem *)[cv cellForItemAtIndexPath:indexPath];
    [datasetCell setSelected];
	
	[_selectedItems addObject:_dataSource[indexPath.row]];
	
	[self setButtonStates];
}

- (void)collectionView:(UICollectionView *)cv didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	RWRedUploadFolderContentItem *datasetCell = (RWRedUploadFolderContentItem *)[cv cellForItemAtIndexPath:indexPath];
    [datasetCell setDeSelected];
	
    [_selectedItems removeObject:_dataSource[indexPath.row]];
	
	[self setButtonStates];
}

- (void)setButtonStates{
	_btnEdit.enabled = NO;
	_btnUpload.enabled = NO;
	
	if(_selectedItems.count == 0){
		return;
	}
	else if(_selectedItems.count == 1){
		_btnEdit.enabled = true;
	}
	
	for(RedUploadImage *image in _selectedItems){
		if(!image.approved){
			return;
		}
	}
	_btnUpload.enabled = true;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(150, 200);
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
	
	RWXmlNode *childPage = [[_xml getPage:[_page getStringFromNode:[RWPAGE CHILD2]]] deepClone];
	
	[childPage addNodeWithName:[RWPAGE FILEPATH] value:redUploadImageObject.localimagepath];
	[childPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
	
	[_app.navController pushViewWithPage:childPage];
}

@end
