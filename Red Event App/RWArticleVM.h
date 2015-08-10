//
//  RWContent.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"
@class RWXMLStore;

@interface RWArticleVM : NSObject

@property(strong, nonatomic) Article *content;

@property(strong, nonatomic) UIImage *image;

- (id)initWithArticle:(Article *)article xml:(RWXMLStore *)xml;

- (NSString *)description;

- (NSNumber *)articleid;

- (NSString *)title;

- (NSString *)alias;

- (NSNumber *)catid;

- (NSString *)introtext;

- (NSString *)introtextWithHtml;

- (NSString *)introtextWithoutHtml;

- (NSString *)fulltext;

- (NSString *)fulltextWithHtml;

- (NSString *)fulltextWithoutHtml;

- (NSString *)introImagePath;

- (NSURL *)introImageUrl;

- (NSString *)mainImagePath;

- (NSURL *)mainImageUrl;

- (NSURL *)imageUrl;

- (NSString *)datePublished;
@end