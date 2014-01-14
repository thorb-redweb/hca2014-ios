//
//  RWStyledSessionListItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/13/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWStyledSessionListItem.h"

#import "RWSessionVM.h"


@implementation RWStyledSessionListItem{
	RWSessionVM *_session;
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
	_session = _dataSource[row];
	_lastRow = !(row < dataSource.count -1);
	
	[self setAppearance];
	[self setCellContents];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	if(!_lastRow){
		[helper setBackgroundColor:_vwSeperator localName:[RWLOOK STYLEDSESSIONLIST_LISTLINECOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	}
	else{
		[helper setBackgroundColor:_vwSeperator localName:[RWLOOK STYLEDSESSIONLIST_LISTLINECOLOR] globalName:[RWLOOK INVISIBLE]];
	}
	
	[helper.label setCustomTextStyle:_lblTitle tag:@"itemtitle" defaultColor:[RWLOOK DEFCOLOR_ALT] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
    [helper.label setCustomTextStyle:_lblBody tag:@"itembody" defaultColor:[RWLOOK DEFCOLOR_ALT] defaultSize:[RWLOOK DEFSIZE_TEXT]];
	
	[helper.button setBackgroundImageFromLocalSource:_btnTakePicture localName:[RWLOOK STYLEDSESSIONLIST_CAMERABUTTONIMAGE]];
	[helper.button setBackgroundImageFromLocalSource:_btnSeeArchive localName:[RWLOOK STYLEDSESSIONLIST_ARCHIVEBUTTONIMAGE]];
}

- (void)setCellContents{
	_lblTitle.text = [NSString stringWithFormat:@"Kl. %@ - %@", _session.startTime, _session.endTime];
    _lblBody.text = _session.title;
}

- (IBAction)btnCameraClicked{
    NSString *childName = [_page getStringFromNode:[RWPAGE CHILD]];
	RWXmlNode *nextPage = [_xml getPage:childName];
	
	[_app.navController pushViewWithPage:nextPage];
}

- (IBAction)btnArchiveClicked{
    NSString *childName = [_page getStringFromNode:[RWPAGE CHILD2]];
	RWXmlNode *nextPage = [[_xml getPage:childName] deepClone];
	[nextPage addNodeWithName:[RWPAGE SESSIONID] value:_session.sessionid];
	
	[_app.navController pushViewWithPage:nextPage];
}

@end
