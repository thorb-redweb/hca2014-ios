//
//  RWDbRedUploadImages.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWDbRedUploadImages.h"
#import "RedUploadImage.h"

#import "RWDbHelper.h"
#import "MyLog.h"
#import "RWDbSchemas.h"

@implementation RWDbRedUploadImages {
	
    RWDbHelper *_dbHelper;
	NSManagedObjectContext *_mContext;
}

- (id)initWithHelper:(RWDbHelper *)helper mContext:(NSManagedObjectContext *)mContext{
    if (self = [super init]) {
        _dbHelper = helper;
		_mContext = mContext;
    }
    else {DDLogWarn(@"RWDbPushMessageGroups not initialized");}
    return self;
}

-(NSMutableArray *)getAll{
	NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas RUI_TABLENAME]];
	
    return fetchResults;
}

-(RedUploadImage *)getFromImagePath:(NSString *)imagePath{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas RUI_LOCALIMAGEPATH], imagePath];
    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas RUI_TABLENAME] predicate:predicate];
	
	if(fetchResults.count > 0){
		return fetchResults[0];
	}
    return nil;
}

-(NSMutableArray *)getFromServerFolder:(NSString *)serverFolder{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", [RWDbSchemas RUI_SERVERFOLDER], serverFolder];
    NSMutableArray *fetchResults = [_dbHelper getFromDatabase:[RWDbSchemas RUI_TABLENAME] predicate:predicate];
	
    return fetchResults;
}

- (bool)noDatabaseEntryWithServerFolder:(NSString *)serverFolder imagePath:(NSString *)imagePath{
	NSString *stringPredicate = [NSString stringWithFormat:@"%@ == '%@' AND %@ != '%@'",
								 [RWDbSchemas RUI_SERVERFOLDER], serverFolder, [RWDbSchemas RUI_LOCALIMAGEPATH], imagePath];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:stringPredicate];
	
    NSArray *result = [_dbHelper getFromDatabase:[RWDbSchemas RUI_TABLENAME] predicate:predicate];
    if (result.count > 0) {
        return NO;
    }
    return YES;
}

- (void)createEntry:(NSDictionary *)entry {
    RedUploadImage *content = (RedUploadImage *) [NSEntityDescription insertNewObjectForEntityForName:[RWDbSchemas RUI_TABLENAME] inManagedObjectContext:_mContext];
	[content setLocalimagepath:[entry objectForKey:[RWDbSchemas RUI_LOCALIMAGEPATH]]];
	[content setServerfolder:[entry objectForKey:[RWDbSchemas RUI_SERVERFOLDER]]];
	
	NSError *cxtError = nil;
    if (![_mContext save:&cxtError]) {
        DDLogError(@"did fail with error");
        DDLogError(@"Context save failed in RWDbRedUploadImages:createEntry: %@", cxtError.description);
		return;
    }
}

- (void)deleteEntryWithImagePath:(NSString *)path {
	RedUploadImage *image = [self getFromImagePath:path];
	if(image != nil){
		[_mContext deleteObject:image];
	}
}

@end
