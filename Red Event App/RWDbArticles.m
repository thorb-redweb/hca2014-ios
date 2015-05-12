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
    else {NSLog(@"RWDbArticles not initialized");}
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

- (NSArray *)getVMListFromCatIds:(NSArray *)catids{
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ == '%d'", [RWDbSchemas ART_CATID], [catids[0] intValue]];
	for (int i = 1; i < catids.count; i++) {
		stringPredicate = [stringPredicate stringByAppendingFormat:@" OR %@ == '%d'", [RWDbSchemas ART_CATID], [catids[i] intValue]];
	}
	NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];
	
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

- (NSArray *)getVMListOfLastThree:(NSArray *)catids{
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ == '%d'", [RWDbSchemas ART_CATID], [catids[0] intValue]];
	for (int i = 1; i < catids.count; i++) {
		stringPredicate = [stringPredicate stringByAppendingFormat:@" OR %@ == '%d'", [RWDbSchemas ART_CATID], [catids[i] intValue]];
	}
	NSPredicate *catpredicate = [NSPredicate predicateWithFormat:stringPredicate];
	NSPredicate *datepredicate = [NSPredicate predicateWithFormat:@"%K <= %@", [RWDbSchemas ART_PUBLISHDATE], [NSDate date]];
	NSArray *subPredicats = [[NSArray alloc] initWithObjects:catpredicate, datepredicate, nil];
	NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicats];
	
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[RWDbSchemas ART_PUBLISHDATE] ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas ART_TABLENAME] predicate:predicate sort:sortDescriptors fetchLimit:3];
	
    NSMutableArray *vmList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Article *article in fetchResults) {
        RWArticleVM *vm = [[RWArticleVM alloc] initWithArticle:article xml:_xml];
        [vmList addObject:vm];
    }
	
    return vmList;
}

#pragma mark Housekeeping Functions

- (void)delete2013Articles{
	//Create the data predicate
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *startOf2014 = [dateFormatter dateFromString:@"2015-01-01 00:00:00"];
	NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"%K < %@",
								  [RWDbSchemas ART_PUBLISHDATE], startOf2014];
	NSPredicate *aboutPagePredicate = [NSPredicate predicateWithFormat:@"%K != 1", [RWDbSchemas ART_ARTICLEID]];
	NSPredicate *fullPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:datePredicate, aboutPagePredicate, nil]];
	
	//Get the implicated articles
	NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas ART_TABLENAME] predicate:fullPredicate];
	
	//Delete the articles
	for(Article *article in result){
		[[_dbHelper getManagedObjectContext] deleteObject:article];
	}
}


@end
