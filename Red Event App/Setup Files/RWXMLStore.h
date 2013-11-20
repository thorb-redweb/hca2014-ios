//
//  RWXMLDistributor.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/19/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import	"RWNode.h"

@interface RWXMLStore : NSObject

@property(strong, nonatomic) RWNode *appearance;
@property(strong, nonatomic) RWNode *pages;
@property(strong, nonatomic) RWNode *text;

@property(strong, nonatomic) NSString *dataFilesFolderPath;
@property(strong, nonatomic) NSString *imagesRootPath;

- (RWNode *)getPage:(NSString *)name;
- (RWNode *)getFrontPage;
- (BOOL)nameBelongsToSwipeView:(NSString *)name;
- (BOOL)swipeViewHasPage:(RWNode *)page;
- (RWNode *)getAppearanceForPage:(NSString *)name;
- (RWNode *)getTextForPage:(NSString *)name;

@end
