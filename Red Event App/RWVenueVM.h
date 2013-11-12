//
//  RWVenueVM.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"

@class RWXMLStore;

@interface RWVenueVM : NSObject

@property(strong, nonatomic) Venue *venue;

- (id)initWithVenue:(Venue *)venue  xml:(RWXMLStore *)xml;

- (int)venueid;

- (NSString *)title;

- (NSString *)address;

- (NSString *)descript;

- (NSString *)descriptionWithHtml;

- (NSString *)descriptionWithoutHtml;

- (NSString *)imagePath;

- (NSURL *)imageUrl;

- (double)latitude;

- (double)longitude;


@end
