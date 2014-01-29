//
//  RWRedUploadFolderViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/13/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIColor+RWColor.h"
#import "UIView+RWViewLayout.h"

#import "RWRedUploadFolderViewController.h"
#import "RWRedUploadSessionFolderListItem.h"
#import "RWRedUploadOtherFolderListItem.h"
#import "RWDbRedUploadImages.h"

#import "RWSessionVM.h"

#import "RWXmlNode.h"
#import "RWAppearanceHelper.h"
#import "RWPAGE.h"
#import "RWVolatileDataStores.h"
#import "RWRedUploadDataStore.h"

@interface RWRedUploadFolderViewController ()

#define sessionNib @"RWRedUploadSessionFolderListItem"
#define otherNib @"RWRedUploadOtherFolderListItem"
#define cellIdentifier @"RWRedUploadFolderListItem"

@end

@implementation RWRedUploadFolderViewController {
    NSArray *dataSource;
	NSString *_folderstype;
	RWRedUploadSessionFolderListItem *prototypecell;
}


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWRedUploadFolderViewController" bundle:nil page:page];
    if (self) {
		_folderstype = [page getStringFromNode:[RWPAGE REDUPLOADFOLDERTYPE]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//TODO: Hacks!!!! Tableview doesn't call numberOfRowsInSection if TranslatesAutoresizingMaskIntoConstraints is set to NO, and the page is in a swipeview. The below if construct "solves" that problem.
	if(![_xml swipeViewHasPage:_page]){
		[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	
	[self setValues];
	[self setAppearance];
	[self setText];
}

- (void)setValues{
	if([_folderstype isEqualToString:[RWPAGE REDUPLOADFOLDERTYPESESSION]]){
		UINib *cellNib = [UINib nibWithNibName:sessionNib bundle:nil];
		[_lstSessions registerNib:cellNib forCellReuseIdentifier:cellIdentifier];
		dataSource = [[_app.volatileDataStores getRedUpload] sessionFolders];
	}
	else if([_folderstype isEqualToString:[RWPAGE REDUPLOADFOLDERTYPEOTHER]]){
		UINib *cellNib = [UINib nibWithNibName:otherNib bundle:nil];
		[_lstSessions registerNib:cellNib forCellReuseIdentifier:cellIdentifier];
		dataSource = [[_app.volatileDataStores getRedUpload] otherFolders];
	}
}

- (void)setAppearance{
	RWAppearanceHelper *helper = _appearanceHelper;

    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[_scrTableScrollView setBackgroundColor:[UIColor colorWithHexString:@"#00000000"]];

    [helper.label setTitleStyle:_lblTitle];

	[_lstSessions setSeparatorStyle:UITableViewCellSeparatorStyleNone];	
}

- (void)setText{
	RWTextHelper *helper = _textHelper;
	
	[helper setText:_lblTitle textName:[RWTEXT STYLEDSESSIONLIST_TITLE] defaultText:[RWDEFAULTTEXT STYLEDSESSIONLIST_TITLE]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    [_lstSessions reloadData];
	[self setTableHeight];
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	NSArray *allItem = [_db.RedUploadImages getAll];
	for(RedUploadImage *image in allItem){
		NSString *local = image.localimagepath;
		NSString *folder = image.serverfolder;
		if(local && folder){}
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view layout

- (void)setTableHeight{
	[_lstSessions layoutIfNeeded];
	CGSize tableViewSize = _lstSessions.contentSize;
	[_lstSessions RWsetHeightAsConstraint:tableViewSize.height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	cell = [self setupCell:cell tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
	
	[cell setNeedsLayout];
	[cell layoutIfNeeded];
	
	CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
	
	height += 1.0f;
	
	return height;
}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//	return 96.0f;
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
    cell = [self setupCell:cell tableView:tableView cellForRowAtIndexPath:indexPath];
	
    return cell;
}

- (UITableViewCell *)setupCell:(UITableViewCell *)cell tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	if([_folderstype isEqualToString:[RWPAGE REDUPLOADFOLDERTYPESESSION]]){
		RWRedUploadSessionFolderListItem *scell = (RWRedUploadSessionFolderListItem *)cell;
		if (scell == nil) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:sessionNib owner:self options:nil];
			scell = [nib objectAtIndex:0];
		}
		[scell initializeCellWithParentPage:_page];
		
		[scell setupCellWithRow:indexPath.row dataSource:dataSource];
		
		scell.lblTitle.preferredMaxLayoutWidth = CGRectGetWidth(tableView.frame) - 116;
		scell.lblBody.preferredMaxLayoutWidth = CGRectGetWidth(tableView.frame) - 116;
		return scell;
	}
	else if([_folderstype isEqualToString:[RWPAGE REDUPLOADFOLDERTYPEOTHER]]){
		RWRedUploadOtherFolderListItem *ocell = (RWRedUploadOtherFolderListItem *)cell;
		if (ocell == nil) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:otherNib owner:self options:nil];
			ocell = [nib objectAtIndex:0];
		}
		[ocell initializeCellWithParentPage:_page];
		
		[ocell setupCellWithRow:indexPath.row dataSource:dataSource];
		
		ocell.lblBody.preferredMaxLayoutWidth = CGRectGetWidth(tableView.frame) - 116;
		return ocell;
	}
	return nil;
}

@end
