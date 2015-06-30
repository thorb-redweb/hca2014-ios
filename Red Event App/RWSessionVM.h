//
//  RWSessionVM.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "Session.h"

@class RWXMLStore;

@interface RWSessionVM : NSObject

@property(strong, nonatomic) Session *session;

@property(strong, nonatomic) UIImage *image;

- (id)initWithSession:(Session *)session xml:(RWXMLStore *)xml;

- (NSString *)description;

- (NSNumber *)sessionid;

- (NSString *)title;

- (NSString *)summary;

- (NSString *)details;

- (NSString *)summaryWithHtml;

- (NSString *)detailsWithHtml;

- (NSDate *)startDatetime;

- (NSString *)startDateLong;

- (NSString *)startDateShort;

- (NSString *)startDay;

- (NSString *)startDateDay;

- (NSString *)startTime;

- (NSDate *)endDatetime;

- (NSString *)endTime;

- (NSString *)submissionPath;

- (NSString *)imagePath;

- (NSURL *)imageUrl;

- (NSString *)venue;

- (double)latitude;

- (double)longitude;

- (NSString *)type;

- (UIColor *)typeColor;

- (UIImage *)typeIcon;

- (BOOL)hasTime;

- (NSString *)websitelink;
@end
