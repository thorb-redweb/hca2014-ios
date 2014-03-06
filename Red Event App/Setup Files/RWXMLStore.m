//
//  RWXMLDistributor.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/19/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWXMLStore.h"
#import	"RWXMLImporter.h"
#import "RWLOOK.h"
#import "RWPAGE.h"
#import "RWTEXT.h"
#import "RWTYPE.h"

@implementation RWXMLStore {
    RWXMLImporter *_importer;
}


- (id)init {

    if (self = [super init]) {
        _importer = [[RWXMLImporter alloc] init];

        _appearance = [_importer getResultNodeFromResource:[RWLOOK APPEARANCEFILENAME] identifier:@"//appearance"];
        _pages = [_importer getResultNodeFromResource:[RWPAGE PAGESFILENAME] identifier:@"//pages"];
		_text = [_importer getResultNodeFromResource:[RWTEXT TEXTFILENAME] identifier:@"//text"];

        RWXmlNode *node = [_importer getResultNodeFromResource:@"server.xml" identifier:@"//network"];
        _dataFilesFolderPath = [[node getChildFromNode:@"datafolder"] getStringFromNode:@"path"];
        _imagesRootPath = [[node getChildFromNode:@"joomla"] getStringFromNode:@"path"];
		_css = [[node getChildFromNode:@"joomla"] getStringFromNode:@"css"];
    }

    return self;
}

- (RWXmlNode *)getPage:(NSString *)name {
    for (RWXmlNode *page in _pages.children) {
        if ([page hasChild:[RWPAGE NAME]] && [[page getStringFromNode:[RWPAGE NAME]] isEqual:name]) {
            return page;
        }
    }
	for (RWXmlNode *page in _pages.children) {
        if ([page hasChild:[RWPAGE TYPE]] && [[page getStringFromNode:[RWPAGE TYPE]] isEqual:name]) {
            return page;
        }
    }
    [NSException raise:@"Missing Page" format:@"No page found in pages.xml with name: '%@'", name];
    return NULL;
}

- (RWXmlNode *)getFrontPage{
	for (RWXmlNode *page in _pages.children) {
        if ([page hasChild:[RWPAGE FRONTPAGE]] && [page getBoolFromNode:[RWPAGE FRONTPAGE]]) {
            return page;
        }
    }
    [NSException raise:@"Missing Frontpage" format:@"No page tagged as frontpage found"];
    return NULL;
}

- (BOOL)nameBelongsToSwipeView:(NSString *)name{
	if ([[[self getPage:name] getStringFromNode:[RWPAGE TYPE]] isEqual:[RWTYPE SWIPEVIEW]]) {
		return true;
	}
	return false;
}

- (BOOL)swipeViewHasPage:(RWXmlNode *)page{
	if ([page hasChild:[RWPAGE PARENT]] && [self nameBelongsToSwipeView:[page getStringFromNode:[RWPAGE PARENT]]]) {
		return true;
	}
	return false;
}

- (RWXmlNode *)getAppearanceForPage:(NSString *)name{
	return [_appearance getChildFromNode:name];
}

- (RWXmlNode *)getTextForPage:(NSString *)name{
	for(RWXmlNode *node in _text.children){
		if ([node.name isEqualToString:name]) {
			return node;
		}
	}
	return nil;
}

@end
