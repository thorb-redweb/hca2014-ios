//
//  RWDbArticles.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWDbArticles.h"
#import "Article.h"
#import "RWArticleVM.h"
#import "RWDbHelper.h"
#import "RWDbSchemas.h"
#import "RWXMLStore.h"
#import "RWJSONSchemas.h"

@implementation RWDbArticles {
    RWDbHelper *_dbHelper;
	RWXMLStore *_xml;
    RWJSONSchemas *_json;
}
- (id)initWithHelper:(RWDbHelper *)helper xml:(RWXMLStore *)xml {
    if (self = [super init]) {
        _dbHelper = helper;
		_xml = xml;
    }
    else {NSLog(@"Database not initialized");}
    return self;
}

#pragma Article Item Functions

- (Article *)getFromId:(int)articleid {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas ART_ARTICLEID], articleid];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas ART_TABLENAME] predicate:predicate];

    if (fetchResults.count > 0) {
        Article *article = [fetchResults objectAtIndex:0];

        return article;
    }

    return NULL;
}

- (RWArticleVM *)getVMFromId:(int)articleid {
    Article *article = [self getFromId:articleid];

    if (article != NULL)
        return [[RWArticleVM alloc] initWithArticle:article xml:_xml];
    return NULL;
}

#pragma Article List Functions

- (NSArray *)getVMListFromCatId:(int)catid {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas ART_CATID], catid];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas ART_PUBLISHDATE] ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas ART_TABLENAME] predicate:predicate sort:sortDescriptors];

    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Article *article in fetchResults) {
        RWArticleVM *vm = [[RWArticleVM alloc] initWithArticle:article xml:_xml];
        [vmList addObject:vm];
    }

    return vmList;
}

@end
