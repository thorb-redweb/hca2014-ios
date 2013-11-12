//
//  NSString+RWString.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RWString)

- (NSString *)stringByStrippingHTML;

- (NSString *)stringByStrippingJoomlaTags;

- (NSString *)htmlStringWithSystemFont;

@end
