//
//  RWBaseListItem.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/14/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWAppDelegate.h"
#import "RWXmlNode.h"

#import "RWLOOK.h"
#import "RWAppearanceHelper.h"
#import "RWTextHelper.h"
#import "RWPAGE.h"

@interface RWBaseListItem : UITableViewCell{
@protected
	NSString *_parentName;
@protected
    RWXmlNode *_page;

@protected
	RWAppDelegate *_app;
@protected
    RWDbInterface *_db;
@protected
    RWServer *_sv;
@protected
    RWXMLStore *_xml;

@protected
    RWAppearanceHelper *_appearanceHelper;
@protected
    RWXmlNode *_localLook;
@protected
    RWXmlNode *_globalLook;
@protected
    RWTextHelper *_textHelper;
}

- (void)initializeCellWithParentPage:(RWXmlNode *)page;

@end
