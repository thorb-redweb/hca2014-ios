//
//  RWDbRedUploadImages.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedUploadImage.h"

@class RWDbHelper;

@interface RWDbRedUploadImages : NSObject

- (id)initWithHelper:(RWDbHelper *)helper mContext:(NSManagedObjectContext *)mContext;

- (NSMutableArray *)getAll;

- (RedUploadImage *)getFromImagePath:(NSString *)imagePath;

- (NSMutableArray *)getFromServerFolder:(NSString*)serverFolder;

- (bool)noDatabaseEntryWithServerFolder:(NSString *)serverFolder imagePath:(NSString *)imagePath;

- (void)createEntry:(NSDictionary *)entry;

- (void)deleteEntryWithImagePath:(NSString *)path;

@end
