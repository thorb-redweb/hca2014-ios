//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "MyLog.h"

#import "RWDbHelper.h"
#import "RWJSONSchemas.h"


@implementation RWDbHelper {
    NSManagedObjectContext *_managedObjectContext;
}


- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        _managedObjectContext = context;
    }
    else {DDLogWarn(@"Database not initialized");}
    return self;
}

-(NSManagedObjectContext *)getManagedObjectContext{
	return _managedObjectContext;
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType {
    return [self getFromDatabase:itemType predicate:nil sort:nil prefetching:nil fetchLimit:0];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate {
    return [self getFromDatabase:itemType predicate:predicate sort:nil prefetching:nil fetchLimit:0];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors {
    return [self getFromDatabase:itemType predicate:predicate sort:sortDescriptors prefetching:nil fetchLimit:0];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate prefetching:(NSArray *)keyPathsForRefetching {
    return [self getFromDatabase:itemType predicate:predicate sort:nil prefetching:keyPathsForRefetching fetchLimit:0];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType sort:(NSArray *)sortDescriptors {
    return [self getFromDatabase:itemType predicate:nil sort:sortDescriptors prefetching:nil fetchLimit:0];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType sort:(NSArray *)sortDescriptors prefetching:(NSArray *)keyPathsForRefetching {
    return [self getFromDatabase:itemType predicate:nil sort:sortDescriptors prefetching:keyPathsForRefetching fetchLimit:0];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType sort:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)fetchLimit {
    return [self getFromDatabase:itemType predicate:nil sort:sortDescriptors prefetching:nil fetchLimit:fetchLimit];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors prefetching:(NSArray *)keyPathsForRefetching {
    return [self getFromDatabase:itemType predicate:predicate sort:sortDescriptors prefetching:keyPathsForRefetching fetchLimit:0];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)fetchLimit {
    return [self getFromDatabase:itemType predicate:predicate sort:sortDescriptors prefetching:nil fetchLimit:fetchLimit];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate prefetching:(NSArray *)keyPathsForRefetching fetchLimit:(NSUInteger)fetchLimit {
    return [self getFromDatabase:itemType predicate:predicate sort:nil prefetching:keyPathsForRefetching fetchLimit:fetchLimit];
}

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors prefetching:(NSArray *)keyPathsForRefetching fetchLimit:(NSUInteger)fetchLimit {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:itemType inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setSortDescriptors:sortDescriptors];
    [request setRelationshipKeyPathsForPrefetching:keyPathsForRefetching];
    [request setFetchLimit:fetchLimit];

    NSError *fetchError = nil;
    NSMutableArray *fetchResults = [[_managedObjectContext executeFetchRequest:request error:&fetchError] mutableCopy];
    if (fetchError != nil) {
        DDLogError(@"did fail with error");
        DDLogError(@"Fetch failed in RWDbHelper:getContentFromDatabase: %@", fetchError.description);
    }

    return fetchResults;
}
@end