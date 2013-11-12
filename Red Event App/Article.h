//
//  Article.h
//  Jule App
//
//  Created by Thorbjørn Steen on 10/29/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Article : NSManagedObject

@property (nonatomic, retain) NSString * alias;
@property (nonatomic, retain) NSNumber * articleid;
@property (nonatomic, retain) NSNumber * catid;
@property (nonatomic, retain) NSString * fulltext;
@property (nonatomic, retain) NSString * introimagepath;
@property (nonatomic, retain) NSString * introtext;
@property (nonatomic, retain) NSDate * publishdate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * mainimagepath;

@end
