//
//  RWXMLHandler.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/21/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWXMLImporter.h"

@implementation RWXMLImporter

- (NSArray *)getResultNodesFromResource:(NSString *)resourceName identifier:(NSString *)nodesForXPath {
    NSArray *resourceParts = [resourceName componentsSeparatedByString:@"."];
    NSString *pathForResource = resourceParts[0];
    NSString *ofType = resourceParts[1];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:pathForResource ofType:ofType];
    NSString *XMLcontent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:XMLcontent options:0 error:nil];

    NSArray *nodes = [document nodesForXPath:nodesForXPath error:nil];

    return [self convertArrayToRWNodes:nodes];
}

- (NSArray *)convertArrayToRWNodes:(NSArray *)elements {
    NSMutableArray *nodeArray = [[NSMutableArray alloc] init];
    for (CXMLElement *element in elements) {
        if (element.childCount == 0) {
            continue;
        }

        [nodeArray addObject:[[RWXmlNode alloc] initWithName:element.name value:[self convertElementToRWNode:element]]];
    }
    return nodeArray;
}

- (NSArray *)convertElementToRWNode:(CXMLElement *)element {
    NSMutableArray *nodeArray = [[NSMutableArray alloc] init];

    for (CXMLElement *child in element.children) {


        CXMLElement *grandchild = 0;
        if (child.childCount > 0) {
            grandchild = child.children[0];
        }

        if (child.childCount == 1 && grandchild.childCount == 0) {
            [nodeArray addObject:[[RWXmlNode alloc] initWithName:child.name value:grandchild.stringValue]];
        }
        else if (child.childCount > 1) {
            [nodeArray addObject:[[RWXmlNode alloc] initWithName:child.name value:[self convertElementToRWNode:child]]];
        }
    }
    return nodeArray;
}


- (RWXmlNode *)getResultNodeFromResource:(NSString *)resourceName identifier:(NSString *)nodesForXPath {
    NSArray *result = [self getResultNodesFromResource:resourceName identifier:nodesForXPath];

    return result[0];
}
@end
