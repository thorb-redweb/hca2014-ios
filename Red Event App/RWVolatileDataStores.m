//
//  RWVolatileDataStores.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/17/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWVolatileDataStores.h"
#import "RWVolatileDataStore.h"
#import "RWRedUploadDataStore.h"

@implementation RWVolatileDataStores{
	NSMutableArray *dataStores;
}

- (id)init{
	if(self = [super init]){
		dataStores = [[NSMutableArray alloc] init];
	}
	return self;
}

- (NSUInteger)count{
	return dataStores.count;
}

- (id)objectAtIndex:(NSUInteger)index{
	return [dataStores objectAtIndex:index];
}

- (void)addObject:(id)anObject{
	[dataStores addObject:anObject];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index{
	[dataStores insertObject:anObject atIndex:index];
}

- (void)removeLastObject{
	[dataStores removeLastObject];
}
- (void)removeObjectAtIndex:(NSUInteger)index{
	[dataStores removeObjectAtIndex:index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
	[dataStores replaceObjectAtIndex:index withObject:anObject];
}


-(RWRedUploadDataStore *)getRedUpload{
    for(RWVolatileDataStore *store in dataStores){
        if([store isKindOfClass:[RWRedUploadDataStore class]]){
            return (RWRedUploadDataStore *)store;
        }
    }
    return nil;
}

@end
