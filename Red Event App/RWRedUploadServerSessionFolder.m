//
//  RWRedUploadServerSessionFolder.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadServerSessionFolder.h"

@implementation RWRedUploadServerSessionFolder


-(id)initWithId:(int)folderid name:(NSString *)name time:(NSString *)time serverfolder:(NSString *)folder{
	if(self = [super initWithId:(int)folderid name:name serverfolder:folder]){
		_time = time;
	}
	return self;
}

@end
