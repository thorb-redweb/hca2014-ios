//
//  RWRedUploadServerOtherFolder.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/17/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadServerOtherFolder.h"

@implementation RWRedUploadServerOtherFolder

-(int)level{
	if (_parent) {
		return _parent.level + 1;
	}
	else{
		return 0;
	}
}

-(id)initWithId:(int)folderId name:(NSString *)name parent:(RWRedUploadServerOtherFolder *)parent serverfolder:(NSString *)folder{
	if(self = [super initWithId:folderId name:name serverfolder:folder]){
		_parent = parent;
	}
	return self;
}

@end
