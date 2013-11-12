//
//  UIView+RWView.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWView.h"

@implementation UIView (RWView)

+ (id)RWloadFromNib {
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *elements = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    for (NSObject *anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            return anObject;
        }
    }
    return nil;
}

@end
