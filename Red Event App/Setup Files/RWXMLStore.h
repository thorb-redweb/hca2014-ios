//
//  RWXMLDistributor.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/19/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWXmlNode.h"

@interface RWXMLStore : NSObject

@property(strong, nonatomic) RWXmlNode *appearance;
@property(strong, nonatomic) RWXmlNode *pages;
@property(strong, nonatomic) RWXmlNode *text;

@property(strong, nonatomic) NSString *dataFilesFolderPath;
@property(strong, nonatomic) NSString *imagesRootPath;

- (RWXmlNode *)getPage:(NSString *)name;
- (RWXmlNode *)getFrontPage;
- (BOOL)nameBelongsToSwipeView:(NSString *)name;
- (BOOL)swipeViewHasPage:(RWXmlNode *)page;
- (RWXmlNode *)getAppearanceForPage:(NSString *)name;
- (RWXmlNode *)getTextForPage:(NSString *)name;

@end
