//
//  RWRedUploadServerSessionFolder.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWRedUploadServerFolder.h"

@interface RWRedUploadServerSessionFolder : RWRedUploadServerFolder

@property (strong, nonatomic) NSString *time;

-(id)initWithId:(int)folderid name:(NSString *)name time:(NSString *)time serverfolder:(NSString *)folder;

@end
