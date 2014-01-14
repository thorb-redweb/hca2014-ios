//
//  RWBaseListItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/14/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWBaseListItem.h"

@implementation RWBaseListItem{
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initializeCellWithParentPage:(RWXmlNode *)page {
	
    _app = [[UIApplication sharedApplication] delegate];
    _db = _app.db;
    _sv = _app.sv;
    _xml = _app.xml;
    _page = page;

    _parentName = [_page getStringFromNode:[RWPAGE NAME]];

    if([_app.xml.appearance hasChild:_parentName])  {
		_localLook = [_app.xml.appearance getChildFromNode:_parentName];
	}
	_globalLook = [_app.xml.appearance getChildFromNode:[RWLOOK DEFAULT]];

    _appearanceHelper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
    _textHelper = [[RWTextHelper alloc] initWithPageName:_parentName xmlStore:_xml];
}

@end
