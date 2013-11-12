//
//  NSDate+RWDate.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSDate+RWDate.h"

@implementation NSDate (RWDate)

- (NSDate *)roundToDate {
    NSDate *date = [self copy];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [gregorian dateFromComponents:components];
}

- (NSDate *)endOfDay {
    NSDate *date = [self copy];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    return [gregorian dateFromComponents:components];
}

@end
