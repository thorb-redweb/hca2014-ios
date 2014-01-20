//
//  RWRedUploadServerFolder.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWRedUploadServerFolder : NSObject

@property (strong, nonatomic) NSNumber *folderId;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *serverFolder;

-(id)initWithId:(int)folderid name:(NSString *)name serverfolder:(NSString *)folder;

-(int)getfolderId;

@end
