//
//  RWRedUploadServerOtherFolder.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/17/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWRedUploadServerFolder.h"

@interface RWRedUploadServerOtherFolder : RWRedUploadServerFolder

@property (strong, nonatomic) RWRedUploadServerOtherFolder *parent;

-(int)level;

-(id)initWithId:(int)folderId name:(NSString *)name parent:(RWRedUploadServerOtherFolder *)parent serverfolder:(NSString *)folder;

@end
