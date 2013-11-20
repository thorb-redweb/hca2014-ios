//
//  RWXMLHandler.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/21/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"
#import "RWXmlNode.h"

@interface RWXMLImporter : NSObject

- (NSArray *)getResultNodesFromResource:(NSString *)resourceName identifier:(NSString *)nodesForXPath;

- (RWXmlNode *)getResultNodeFromResource:(NSString *)resourceName identifier:(NSString *)nodesForXPath;

@end
