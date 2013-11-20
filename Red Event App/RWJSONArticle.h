//
// Created by Thorbjørn Steen on 11/18/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface RWJSONArticle : NSObject
- (NSString *)ARTICLE_ID;

- (NSString *)CATID;

- (NSString *)TITLE;

- (NSString *)ALIAS;

- (NSString *)INTROTEXT;

- (NSString *)FULLTEXT;

- (NSString *)INTROIMAGEPATH;

- (NSString *)MAINIMAGEPATH;

- (NSString *)PUBLISHDATE;

- (NSString *)ITEMTYPE;

- (NSString *)ACTIONTYPE;
@end