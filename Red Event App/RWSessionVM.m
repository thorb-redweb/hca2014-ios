//
//  RWSessionVM.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"
#import "UIColor+RWColor.h"

#import "RWSessionVM.h"
#import "Event.h"
#import "Venue.h"

#import "RWXMLStore.h"

@implementation RWSessionVM{
	NSString *imagesRootPath;
}

- (id)initWithSession:(Session *)session xml:(RWXMLStore *)xml {
    if (self = [super init]) {
        _session = session;
		imagesRootPath = xml.imagesRootPath;
    }
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"RWSessionVM: \nsessionid: %@\ntitle: %@\nsummary: %@\ndetails: %@\nstartdatetime: %@\nenddatetime: %@\nsubmissionpath: %@\nimagepath: %@\nvenue: %@\nlatitude: %f\nlongitude: %f\nhasTime: %i", self.sessionid, _session.event.title, self.summary, self.details, self.startDatetime, self.endDatetime, self.submissionPath, self.imagePath, self.venue, self.latitude, self.longitude, self.hasTime];
    return description;
}

- (NSNumber *)sessionid; {
    return _session.sessionid;
}

- (NSString *)title {
    if ([_session.title length] != 0) {
        return _session.title;
    }
    else {
        return _session.event.title;
    }
}

- (NSString *)summary {
    if ([_session.event.summary length] != 0) {
        return [_session.event.summary stringByStrippingHTML];
    }
    else {
        return [_session.event.details stringByStrippingHTML];
    }
}

- (NSString *)details {
	NSString *rawDetails = [NSString stringWithFormat:@"%@<br/>%@", _session.event.details, _session.details];
	NSString *stripedDetails = [rawDetails stringByStrippingHTML];
    return stripedDetails;
}

- (NSString *)summaryWithHtml {
    if (_session.event.summary != NULL) {
        return [_session.event.summary htmlStringWithSystemFont];
    }
    else {
        return [_session.event.details htmlStringWithSystemFont];
    }
}

- (NSString *)detailsWithHtml {
    return [[NSString stringWithFormat:@"%@<br/>%@", _session.event.details, _session.details] htmlStringWithSystemFont];
}

- (NSDate *)startDatetime {
    return _session.startdatetime;
}

- (NSString *)startDateLong {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, dd.MM.yyyy"];
    return [dateFormatter stringFromDate:_session.startdatetime];
}

- (NSString *)startDateShort {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d. MMMM"];
    return [dateFormatter stringFromDate:_session.startdatetime];
}

- (NSString *)startDateDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd."];
    return [dateFormatter stringFromDate:_session.startdatetime];
}

- (NSString *)startTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH.mm"];
    return [dateFormatter stringFromDate:_session.startdatetime];
}

- (NSDate *)endDatetime {
    return _session.enddatetime;
}

- (NSString *)endTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH.mm"];
    return [dateFormatter stringFromDate:_session.enddatetime];
}

- (NSString *)submissionPath {
    return _session.event.submission;
}

- (NSString *)imagePath {
	Event *event = _session.event;
    return event.imagepath;
}

- (NSURL *)imageUrl{
	NSMutableString *urlString = [[NSMutableString alloc] initWithString:imagesRootPath];
	NSString *imagePath = [[self imagePath] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
    [urlString appendString:imagePath];
	return [NSURL URLWithString:urlString];
}

- (NSString *)venue {
    return _session.venue.title;
}

- (double)latitude {
    return _session.venue.latitude.doubleValue;
}

- (double)longitude {
    return _session.venue.longitude.doubleValue;
}

- (NSString *)type{
	return _session.type;
}

- (UIColor *)typeColor{
	if ([_session.type isEqualToString:@"Kulturformidling"]){
		return [UIColor colorWithHexString:@"#205aa8"];
	}
	else if ([_session.type isEqualToString:@"Kunst og kultur"]){
		return [UIColor colorWithHexString:@"#8e8e8e"];
	}
	else if ([_session.type isEqualToString:@"Leg og læring"]){
		return [UIColor colorWithHexString:@"#498825"];
	}
	else if ([_session.type isEqualToString:@"Musik"]){
		return [UIColor colorWithHexString:@"#e38224"];
	}
	else if ([_session.type isEqualToString:@"Spoken Word"]){
		return [UIColor colorWithHexString:@"#3c3746"];
	}
	else if ([_session.type isEqualToString:@"Underholdning og teater"]){
		return [UIColor colorWithHexString:@"#e10071"];
	}
	return [UIColor blackColor];
}

- (UIImage *)typeIcon{
	
	if ([_session.type isEqualToString:@"Kulturformidling"]){
		return [UIImage imageNamed:@"culture"];
	}
	else if ([_session.type isEqualToString:@"Kunst og kultur"]){
		return [UIImage imageNamed:@"art"];
	}
	else if ([_session.type isEqualToString:@"Leg og læring"]){
		return [UIImage imageNamed:@"play"];
	}
	else if ([_session.type isEqualToString:@"Musik"]){
		return [UIImage imageNamed:@"music"];
	}
	else if ([_session.type isEqualToString:@"Spoken Word"]){
		return [UIImage imageNamed:@"spoken"];
	}
	else if ([_session.type isEqualToString:@"Underholdning og teater"]){
		return [UIImage imageNamed:@"theater"];
	}
	return [UIImage imageNamed:@"default_icon"];
}

- (BOOL)hasTime {
    return ![[self startTime] isEqual:[self endTime]];
}

@end
