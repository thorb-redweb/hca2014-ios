//
//  RWRedUploadDataStore.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadDataStore.h"
#import "RWDbInterface.h"
#import "RWDbRedUploadImages.h"
#import "RWRedUploadServerFolder.h"
#import "RWRedUploadServerOtherFolder.h"
#import "RWRedUploadServerSessionFolder.h"

@implementation RWRedUploadDataStore

-(id)initWithDb:(RWDbInterface *)db{
	if (self = [super init]) {
		_redUploadImages = [db.RedUploadImages getAll];

		_sessionFolders = [[NSMutableArray alloc] init];
		[_sessionFolders addObject:[[RWRedUploadServerSessionFolder alloc] initWithId:1 name:@"Odense Marcipan og Claus Bager" time:@"Kl. 10.00 - 12.00" serverfolder:@"testFolder"]];
		[_sessionFolders addObject:[[RWRedUploadServerSessionFolder alloc] initWithId:2 name:@"Klaveret, der kom forbi - med Findus og Den Halve Kvartet" time:@"Kl. 10.00" serverfolder:@"testFolder"]];
		[_sessionFolders addObject:[[RWRedUploadServerSessionFolder alloc] initWithId:3 name:@"Medicinernes Luciakor" time:@"Efter mørkets frembrud" serverfolder:@"testFolder"]];

		_otherFolders = [[NSMutableArray alloc] init];
		[_otherFolders addObject:[[RWRedUploadServerOtherFolder alloc] initWithId:4 name:@"Art slideshow" parent:nil serverfolder:@"testFolder"]];
		[_otherFolders addObject:[[RWRedUploadServerOtherFolder alloc] initWithId:5 name:@"The Hospital" parent:nil serverfolder:@"testFolder"]];
		RWRedUploadServerOtherFolder *miscFolder = [[RWRedUploadServerOtherFolder alloc] initWithId:6 name:@"Miscellaneous" parent:nil serverfolder:@"testFolder"];
		[_otherFolders addObject:miscFolder];
		[_otherFolders addObject:[[RWRedUploadServerOtherFolder alloc] initWithId:7 name:@"Children playing" parent:miscFolder serverfolder:@"testFolder"]];
		[_otherFolders addObject:[[RWRedUploadServerOtherFolder alloc] initWithId:8 name:@"Families" parent:miscFolder serverfolder:@"testFolder"]];
		[_otherFolders addObject:[[RWRedUploadServerOtherFolder alloc] initWithId:9 name:@"The personel" parent:nil serverfolder:@"testFolder"]];
		
		[self cleanUpImagesWithServerFoldersThatNoLongerExist:db];
	}
	return self;
}

- (void)cleanUpImagesWithServerFoldersThatNoLongerExist:(RWDbInterface *)db{
	NSMutableArray *redUploadImages = [db.RedUploadImages getAll];
	
	for (RedUploadImage *image in redUploadImages) {
		bool folderDoesntExist = YES;
		for (RWRedUploadServerFolder *folder in _sessionFolders) {
			if (folder.serverFolder == image.serverfolder) {
				folderDoesntExist = NO;
				break;
			}
		}
		if(folderDoesntExist){
			[db.RedUploadImages deleteEntryWithImagePath:image.localimagepath];
		}
	}
}

-(RWRedUploadServerFolder *)getFolder:(int)folderId{
	for (RWRedUploadServerFolder *folder in _sessionFolders) {
		if (folderId == [folder getfolderId]) {
			return folder;
		}
	}
	for (RWRedUploadServerFolder *folder in _otherFolders) {
		if (folderId == [folder getfolderId]) {
			return folder;
		}
	}
	return nil;
}

@end
