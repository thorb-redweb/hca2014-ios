//
//  RWRedUploadOtherFolderListItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/17/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWRedUploadOtherFolderListItem.h"
#import "RWRedUploadServerOtherFolder.h"

#import "RWAppearanceHelper.h"

@implementation RWRedUploadOtherFolderListItem{
	RWRedUploadServerOtherFolder *_folder;
	NSArray *_dataSource;
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
	[self.vwBox setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	_dataSource = dataSource;
	_folder = _dataSource[row];
		
	[self setControls];
	[self setAppearance];
	[self setCellContents];
}

- (void)setControls{
	int level = _folder.level;
	if(level == 0){
		[_topConstraint setConstant:10];
	}
	[_leftConstraint setConstant:level*10];

}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundAsShape:_vwBox localBackgroundColorName:[RWLOOK REDUPLOADFOLDERVIEW_LISTBACKGROUNDCOLOR] globalBackgroundColorName:[RWLOOK DEFAULT_ALTCOLOR] borderWidth:2.0f localBorderColorName:[RWLOOK REDUPLOADFOLDERVIEW_LISTLINECOLOR] globalBorderColorName:[RWLOOK DEFAULT_ALTTEXTCOLOR] cornerRadius:5];
	
    [helper.label setCustomTextStyle:_lblBody tag:@"itembody" defaultColor:[RWLOOK DEFCOLOR_ALT] defaultSize:[RWLOOK DEFSIZE_TEXT]];
	
	[helper.button setBackgroundImageFromLocalSource:_btnTakePicture localName:[RWLOOK REDUPLOADFOLDERVIEW_CAMERABUTTONIMAGE]];
	[helper.button setBackgroundImageFromLocalSource:_btnSeeArchive localName:[RWLOOK REDUPLOADFOLDERVIEW_ARCHIVEBUTTONIMAGE]];
}

- (void)setCellContents{
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
