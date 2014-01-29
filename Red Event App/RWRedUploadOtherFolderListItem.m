//
//  RWRedUploadOtherFolderListItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/17/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RedUploadImage.h"
#import "RWRedUploadOtherFolderListItem.h"
#import "RWRedUploadServerOtherFolder.h"

#import "RWAppearanceHelper.h"
#import "RWDbRedUploadImages.h"

@implementation RWRedUploadOtherFolderListItem{
	RWRedUploadServerOtherFolder *_folder;
	bool _archiveEmpty;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource{
	[_vwFrontBox setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_vwBackBox setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	_folder = dataSource[row];
	
	[self setValues:row dataSource:dataSource];
	[self setControls];
	[self setCellContents];
	[self setAppearance];
}

- (void)setValues:(int)row dataSource:(NSArray *)dataSource{
	_archiveEmpty = [_db.RedUploadImages getFromServerFolder:_folder.serverFolder].count == 0;
}

- (void)setControls{
	if (_archiveEmpty) {
		[_btnSeeArchive setEnabled:NO];
	}
}

- (void)setCellContents{
    _lblBody.text = _folder.name;
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	if(_folder.level == 0){
		[helper setBackgroundAsShape:_vwFrontBox localBackgroundColorName:[RWLOOK REDUPLOAD_ITEMBACKGROUNDCOLOR] globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:2 localBorderColorName:@"itembordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	}
	else {
		[helper setBackgroundAsShape:_vwFrontBox localBackgroundColorName:[RWLOOK REDUPLOAD_ITEMBACKGROUNDCOLOR] globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:2 localBorderColorName:@"itembordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:0];
	}
	[helper setBackgroundAsShape:_vwBackBox localBackgroundColorName:[RWLOOK REDUPLOAD_ITEMBACKGROUNDCOLOR] globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:2 localBorderColorName:@"itembordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:0];
	
	
	[helper.label setAltTextStyle:_lblBody];
	
	[helper setBackgroundColor:_btnTakePicture localName:@"camerabuttoncolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	[helper.button setImageFromLocalSource:_btnTakePicture localName:[RWLOOK REDUPLOADFOLDERVIEW_CAMERABUTTONIMAGE]];
	[helper.button setImageFromLocalSource:_btnSeeArchive localName:[RWLOOK REDUPLOADFOLDERVIEW_ARCHIVEBUTTONIMAGE]];
	
	int level = _folder.level;
	int leftPadding = 15 * level;
	int topPadding = -2;
	if(level == 0){
		topPadding = 10;
	}
	
	[_frontTopConstraint setConstant:topPadding];
	[_leftConstraint setConstant:leftPadding];
}

- (IBAction)btnCameraClicked{
    NSString *childName = [_page getStringFromNode:[RWPAGE CHILD]];
	RWXmlNode *nextPage = [[_xml getPage:childName] deepClone];
	
    [nextPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
	
    [_app.navController pushViewWithPage:nextPage];
}

- (IBAction)btnArchiveClicked{
    NSString *childName = [_page getStringFromNode:[RWPAGE CHILD2]];
	RWXmlNode *nextPage = [[_xml getPage:childName] deepClone];
	
    [nextPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
	
	[_app.navController pushViewWithPage:nextPage];
}


@end
