//
//  RWRedUploadDataStore.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWVolatileDataStore.h"
#import "RWRedUploadServerFolder.h"

@class RWDbInterface;

@interface RWRedUploadDataStore : RWVolatileDataStore

@property (strong, nonatomic) NSMutableArray *sessionFolders;
@property (strong, nonatomic) NSMutableArray *otherFolders;

-(id)initWithDb:(RWDbInterface *)db;

-(RWRedUploadServerFolder *)getFolder:(int)folderId;

@end
