//
//  RWXmlNode.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/21/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWXmlNode.h"
#import "RWPAGE.h"

@implementation RWXmlNode {
    int iteratorIndex;
}

- (id)initWithName:(NSString *)name value:(id)value {
    if (self = [super init]) {
        _name = name;
        _value = value;
    }
    return self;
}

- (NSString *)description {
    NSString *class = @"RWXmlNode";
    NSString *value;
    if ([_value class] == [NSArray class]) {
        NSArray *array = _value;
        value = array.description;
    }
    else {
        NSString *string = _value;
        value = string.description;
    }
    NSString *description = [NSString stringWithFormat:@"%@: {%@, %@}", class, _name, value];
    return description;
}

- (int)childCount {
    if ([_value isKindOfClass:[NSArray class]]) {
        NSArray *array = _value;

        return array.count;
    }
    return 0;
}

- (NSString *)getStringFromNode:(NSString *)name {
    for (RWXmlNode *child in self.value) {
        if ([child.name isEqual:name]) {
            return child.value;
        }
    }
    NSString *errorName = [self name];
    if ([errorName isEqual:[RWPAGE PAGE]])
        errorName = [NSString stringWithFormat:@"page: %@", [self getStringFromNode:[RWPAGE NAME]]];
    [NSException raise:@"Missing XML Element" format:@"'%@' is missing from XML Element '%@'", name, errorName];
    return NULL;
}

- (bool)getBoolFromNode:(NSString *)name {
    return [[self getStringFromNode:name] boolValue];
}

- (double)getDoubleFromNode:(NSString *)name {
    return [[self getStringFromNode:name] doubleValue];
}

- (float)getFloatFromNode:(NSString *)name {
    return [[self getStringFromNode:name] doubleValue];
}

- (int)getIntegerFromNode:(NSString *)name {
    return [[self getStringFromNode:name] intValue];
}

- (NSArray *) getNSNumberArrayFromNode:(NSString *)name{
	NSArray *stringNums = [[self getStringFromNode:name] componentsSeparatedByString:@","];
	NSMutableArray *intArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < stringNums.count; i++) {
		[intArray addObject: [NSNumber numberWithInteger:[stringNums[i] intValue]]];
	}
	return intArray;
}


- (NSArray *)getAllChildValuesWithName:(NSString *)name{
	NSMutableArray *nodeArray = [[NSMutableArray alloc]init];
	for (int i = 0; i < self.childCount; i++) {
        RWXmlNode *child = self.value[i];
        if ([child.name isEqual:name])
            [nodeArray addObject:child.value];
    }
	return nodeArray;
}

- (RWXmlNode *)getChildFromNode:(NSString *)name {

    for (int i = 0; i < self.childCount; i++) {
        RWXmlNode *child = self.value[i];
        if ([child.name isEqual:name])
            return child;
    }
    NSString *errorName = [self name];
    if ([errorName isEqual:[RWPAGE PAGE]])
        errorName = [NSString stringWithFormat:@"page: %@", [self getStringFromNode:[RWPAGE NAME]]];
    [NSException raise:@"Missing XML Element" format:@"'%@' is missing from XML Element '%@'", name, errorName];
    return NULL;
}

- (NSArray *)getAllChildNodesWithName:(NSString *)name{
	NSMutableArray *nodeArray = [[NSMutableArray alloc]init];
	for (int i = 0; i < self.childCount; i++) {
        RWXmlNode *child = self.value[i];
        if ([child.name isEqual:name])
            [nodeArray addObject:child];
    }
	return nodeArray;
}

- (NSDictionary *)getDictionaryFromNode {
    return [self getDictionaryFromChildNode:self];
}

- (NSDictionary *)getDictionaryFromChildNode:(RWXmlNode *)node {

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

    for (RWXmlNode *child in node.value) {
        if ([child.value isKindOfClass:[NSArray class]]) {
            NSDictionary *childDictionary = [self getDictionaryFromChildNode:child];
            [dictionary setObject:childDictionary forKey:child.name];
        }
        else {
            [dictionary setObject:child.value forKey:child.name];
        }
    }

    return dictionary;
}

- (BOOL)hasChild:(NSString *)childname {
    if (![_value isKindOfClass:[NSArray class]]) {
        return false;
    }
    for (int i = 0; i < self.childCount; i++) {
        RWXmlNode *child = self[i];
        if ([child.name isEqual:childname])
            return true;
    }
    return false;
}

- (NSArray *)children {
    if (self.childCount == 0) {
        return nil;
    }
    NSArray *valueArray = _value;
    return valueArray;
}

- (RWXmlNode *)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self children][idx];
}
@end
