//
//  RWNode.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/21/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWNode : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) id value;

- (id)initWithName:(NSString *)name value:(id)value;

- (NSString *)description;

- (int)childCount;

- (NSString *)getStringFromNode:(NSString *)name;

- (bool)getBoolFromNode:(NSString *)name;

- (double)getDoubleFromNode:(NSString *)name;

- (float)getFloatFromNode:(NSString *)name;

- (int)getIntegerFromNode:(NSString *)name;

- (NSArray *)getNSNumberArrayFromNode:(NSString *)name;

- (NSArray *)getAllChildValuesWithName:(NSString *)name;

- (RWNode *)getChildFromNode:(NSString *)name;

- (NSArray *)getAllChildNodesWithName:(NSString *)name;

- (NSDictionary *)getDictionaryFromNode;

- (BOOL)hasChild:(NSString *)childname;

- (NSArray *)children;

- (RWNode *)objectAtIndexedSubscript:(NSUInteger)idx;

@end
