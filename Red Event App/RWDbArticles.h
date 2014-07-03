//
//  RWDbArticles.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWDbHelper;
@class Article;
@class RWArticleVM;
@class RWXMLStore;

@interface RWDbArticles : NSObject

- (id)initWithHelper:(RWDbHelper *)context xml:(RWXMLStore *)xml;

- (Article *)getFromId:(int)articleid;

- (RWArticleVM *)getVMFromId:(int)articleid;

- (NSArray *)getVMListFromCatId:(int)catid;
- (NSArray *)getVMListFromCatIds:(NSArray *)catids;

- (NSArray *)getVMListOfLastThree:(NSArray *)catid;
@end
