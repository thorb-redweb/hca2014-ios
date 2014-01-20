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


@implementation RWRedUploadSessionFolderListItem {
	RWRedUploadServerSessionFolder *_folder;
	NSArray *_dataSource;
	bool _lastRow;
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
}

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource{
	
	_dataSource = dataSource;
	_folder = _dataSource[row];
	_lastRow = !(row < dataSource.count -1);	
	
	[self setAppearance];
	[self setCellContents];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	if(!_lastRow){
		[helper setBackgroundColor:_vwSeperator localName:[RWLOOK REDUPLOADFOLDERVIEW_LISTLINECOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	}
	else{
		[helper setBackgroundColor:_vwSeperator localName:nil globalName:[RWLOOK INVISIBLE]];
	}
	
	[helper.label setCustomTextStyle:_lblTitle tag:@"itemtitle" defaultColor:[RWLOOK DEFCOLOR_ALT] defaultSize:[RWLOOK DEFSIZE_TEXT]];
    [helper.label setCustomTextStyle:_lblBody tag:@"itembody" defaultColor:[RWLOOK DEFCOLOR_ALT] defaultSize:[RWLOOK DEFSIZE_TEXT]];
	
	[helper.button setBackgroundImageFromLocalSource:_btnTakePicture localName:[RWLOOK REDUPLOADFOLDERVIEW_CAMERABUTTONIMAGE]];
	[helper.button setBackgroundImageFromLocalSource:_btnSeeArchive localName:[RWLOOK REDUPLOADFOLDERVIEW_ARCHIVEBUTTONIMAGE]];
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
    NSString *childName = [_page getStringFromNode:[RWPAGE CHILD2]];
	RWXmlNode *nextPage = [[_xml getPage:childName] deepClone];
	
	[nextPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
	
	[_app.navController pushViewWithPage:nextPage];
}

@end
