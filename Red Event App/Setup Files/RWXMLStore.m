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

        RWNode *node = [_importer getResultNodeFromResource:@"joomlasite.xml" identifier:@"//network"];
        _dataFilesFolderPath = [[node getChildFromNode:@"datafolder"] getStringFromNode:@"path"];
        _imagesRootPath = [[node getChildFromNode:@"joomla"] getStringFromNode:@"path"];
    }

    return self;
}

- (RWNode *)getPage:(NSString *)name {
    for (RWNode *page in _pages.children) {
        if ([page hasChild:[RWPAGE NAME]] && [[page getStringFromNode:[RWPAGE NAME]] isEqual:name]) {
            return page;
        }
    }
	for (RWNode *page in _pages.children) {
        if ([page hasChild:[RWPAGE TYPE]] && [[page getStringFromNode:[RWPAGE TYPE]] isEqual:name]) {
            return page;
        }
    }
    [NSException raise:@"Missing Page" format:@"No page found in pages.xml with name: '%@'", name];
    return NULL;
}

- (RWNode *)getFrontPage{
	for (RWNode *page in _pages.children) {
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

- (BOOL)swipeViewHasPage:(RWNode *)page{
	if ([page hasChild:[RWPAGE PARENT]] && [self nameBelongsToSwipeView:[page getStringFromNode:[RWPAGE PARENT]]]) {
		return true;
	}
//	for (RWNode *possibleSwipeView in _pages.children) {
//        if ([possibleSwipeView hasChild:[RWPAGE TYPE]] && [[possibleSwipeView getStringFromNode:[RWPAGE TYPE]] isEqual:[RWTYPE SWIPEVIEW]]) {
//			RWNode *swipeView = possibleSwipeView;
//			NSArray *sections = [swipeView getAllChildValuesWithName:[RWPAGE SECTION]];
//			for(NSString *name in sections){
//				if ([name isEqual:[page getStringFromNode:[RWPAGE NAME]]]) {
//					return true;
//				}
//			}
//        }
//    }
	return false;
}

- (RWNode *)getAppearanceForPage:(NSString *)name{
	return [_appearance getChildFromNode:name];
}

- (RWNode *)getTextForPage:(NSString *)name{
	for(RWNode *node in _text.children){
		if ([node.name isEqualToString:name]) {
			return node;
		}
	}
	return nil;
}

@end
