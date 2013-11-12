//
//  RWVenueVM.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"
#import "RWVenueVM.h"
#import "RWXMLStore.h"

@implementation RWVenueVM{
	NSString *imagesRootPath;
}

- (id)initWithVenue:(Venue *)venue xml:(RWXMLStore *)xml{
    if (self = [super init]) {
        _venue = venue;
		imagesRootPath = xml.imagesRootPath;
    }
    return self;
}

- (int)venueid {
    return [_venue.venueid intValue];
}

- (NSString *)title {
    return _venue.title;
}

- (NSString *)address{
	return [[NSString alloc] initWithFormat:@"%@, %@", _venue.street, _venue.city];
}

- (NSString *)descript{
	return _venue.descript;
}

- (NSString *)descriptionWithHtml{
	return [[self descript] stringByStrippingJoomlaTags];
}

- (NSString *)descriptionWithoutHtml{
	return [[self descript] stringByStrippingHTML];
}

- (NSString *)imagePath{
	return _venue.imagepath;
}

- (NSURL *)imageUrl{
	NSMutableString *urlString = [[NSMutableString alloc] initWithString:imagesRootPath];
    [urlString appendString:[self imagePath]];
	return [NSURL URLWithString:urlString];
}

- (double)latitude {
    return [_venue.latitude doubleValue];
}

- (double)longitude {
    return [_venue.longitude doubleValue];
}

@end
