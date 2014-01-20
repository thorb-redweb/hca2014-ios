//
//  RWVolatileDataStores.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/17/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RWRedUploadDataStore;

@interface RWVolatileDataStores : NSObject

- (id)init;
- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

-(RWRedUploadDataStore *)getRedUpload;
@end
