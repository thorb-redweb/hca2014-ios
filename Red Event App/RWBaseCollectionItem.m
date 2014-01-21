//
//  RWBaseCollectionItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWBaseCollectionItem.h"

@implementation RWBaseCollectionItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
