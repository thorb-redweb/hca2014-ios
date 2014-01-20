//
//  RWRedUploadServerFolder.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadServerFolder.h"

@implementation RWRedUploadServerFolder

-(id)initWithId:(int)folderid name:(NSString *)name serverfolder:(NSString *)folder{
	if(self = [super init]){
		_folderId = [NSNumber numberWithInt:folderid];
		_name = name;
		_serverFolder = folder;
	}
	return self;
}

-(int)getfolderId{
    return _folderId.intValue;
}

@end
