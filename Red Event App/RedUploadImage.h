//
//  RedUploadImage.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RedUploadImage : NSManagedObject

@property (nonatomic, retain) NSString * localimagepath;
@property (nonatomic, retain) NSString * serverfolder;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * approved;

@end
