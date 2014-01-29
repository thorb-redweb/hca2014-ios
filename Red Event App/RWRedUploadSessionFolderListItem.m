//
//  RWRedUploadSessionFolderListItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/13/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadSessionFolderListItem.h"

#import "RWSessionVM.h"
#import "RWRedUploadServerSessionFolder.h"
#import "RWDbRedUploadImages.h"


@implementation RWRedUploadSessionFolderListItem {
	RWRedUploadServerSessionFolder *_folder;
	
	bool _archiveEmpty;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource{
	_folder = dataSource[row];
	
	[self setValues:row dataSource:dataSource];
	[self setControls];
	[self setAppearance];
	[self setCellContents];
}

- (void)setValues:(int)row dataSource:(NSArray *)dataSource{
	_archiveEmpty = [_db.RedUploadImages getFromServerFolder:_folder.serverFolder].count == 0;
}

- (void)setControls{
	if (_archiveEmpty) {
		[_btnSeeArchive setEnabled:NO];
	}
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundAsShape:_vwFrontBox localBackgroundColorName:[RWLOOK REDUPLOAD_ITEMBACKGROUNDCOLOR] globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:2 localBorderColorName:@"itembordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	[helper setBackgroundAsShape:_vwBackBox localBackgroundColorName:[RWLOOK REDUPLOAD_ITEMBACKGROUNDCOLOR] globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:2 localBorderColorName:@"itembordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:0];
	
	
	[helper setBackgroundColor:_btnTakePicture localName:@"camerabuttoncolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	[helper.button setImageFromLocalSource:_btnTakePicture localName:@"camerabuttonimage"];
	
	
	[helper.button setImageFromLocalSource:_btnSeeArchive localName:@"archivebuttonimage"];
	
	[helper.label setAltItemTitleStyle:_lblTitle];
    [helper.label setAltTextStyle:_lblBody];
}

- (void)setCellContents{
	_lblTitle.text = _folder.time;
    _lblBody.text = _folder.name;
}

- (IBAction)btnCameraClicked{
    NSString *childName = [_page getStringFromNode:[RWPAGE CHILD]];
	RWXmlNode *nextPage = [[_xml getPage:childName] deepClone];

    [nextPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];

    [_app.navController pushViewWithPage:nextPage];
}

- (IBAction)btnArchiveClicked{
	if(!_archiveEmpty){
		NSString *childName = [_page getStringFromNode:[RWPAGE CHILD2]];
		RWXmlNode *nextPage = [[_xml getPage:childName] deepClone];
		
		[nextPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
		
		[_app.navController pushViewWithPage:nextPage];
	}
}

@end
