//
// Created by Thorbjørn Steen on 9/27/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RWJSONSchemas;


@interface RWDbHelper : NSObject

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate prefetching:(NSArray *)keyPathsForRefetching;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType sort:(NSArray *)sortDescriptors;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType sort:(NSArray *)sortDescriptors prefetching:(NSArray *)keyPathsForRefetching;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType sort:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)fetchLimit;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors prefetching:(NSArray *)keyPathsForRefetching;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)fetchLimit;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate prefetching:(NSArray *)keyPathsForRefetching fetchLimit:(NSUInteger)fetchLimit;

- (NSMutableArray *)getFromDatabase:(NSString *)itemType predicate:(NSPredicate *)predicate sort:(NSArray *)sortDescriptors prefetching:(NSArray *)keyPathsForRefetching fetchLimit:(NSUInteger)fetchLimit;
@end