//
//  NSString+RWString.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"

@implementation NSString (RWString)

- (NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"&nbsp;" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@" "];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    s = [s stringByStrippingJoomlaTags];
    return s;
}

- (NSString *)stringByStrippingJoomlaTags {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"\\[.*?\\]\r\n" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    while ((r = [s rangeOfString:@"\\[.*?\\]" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
//    while ((r = [s rangeOfString:@"<a href[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
//        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (NSString *)htmlStringWithSystemFont {
    NSString *s = [self copy];
    s = [s stringByStrippingJoomlaTags];
    UIFont *systemfont = [UIFont systemFontOfSize:14];
    NSString *font = systemfont.familyName;
    NSNumber *fontsize = [NSNumber numberWithInt:14];
    s = [NSString stringWithFormat:@"<html><head><style type=\"text/css\">body {font-family\"%@\"; font-size: %@;}</style></head><body>%@</body></html>", font, fontsize, s];
    return s;
}

@end
