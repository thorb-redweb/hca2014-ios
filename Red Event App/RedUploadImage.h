//
//  RedUploadImage.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/16/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RedUploadImage : NSManagedObject

@property (nonatomic, retain) NSString * localimagepath;
@property (nonatomic, retain) NSString * serverfolder;

@end
