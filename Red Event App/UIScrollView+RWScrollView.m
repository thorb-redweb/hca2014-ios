//
//  UIScrollView+RWScrollView.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/12/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIScrollView+RWScrollView.h"

@implementation UIScrollView (RWScrollView)

- (void)RWContentSizeToFit {
    UIScrollView *scrollview = self;
    CGFloat lowestPoint = 0.0;

    BOOL restoreHorizontal = NO;
    BOOL restoreVertical = NO;

    if ([scrollview respondsToSelector:@selector(setShowsHorizontalScrollIndicator:)] && [scrollview respondsToSelector:@selector(setShowsVerticalScrollIndicator:)]) {
        if ([scrollview showsHorizontalScrollIndicator]) {
            restoreHorizontal = YES;
            [scrollview setShowsHorizontalScrollIndicator:NO];
        }
        if ([scrollview showsVerticalScrollIndicator]) {
            restoreVertical = YES;
            [scrollview setShowsVerticalScrollIndicator:NO];
        }
    }
    for (UIView *subView in scrollview.subviews) {
        if (!subView.hidden) {
            CGFloat maxY = CGRectGetMaxY(subView.frame);
            if (maxY > lowestPoint) {
                lowestPoint = maxY;
            }
        }
    }
    if ([scrollview respondsToSelector:@selector(setShowsHorizontalScrollIndicator:)] && [scrollview respondsToSelector:@selector(setShowsVerticalScrollIndicator:)]) {
        if (restoreHorizontal) {
            [scrollview setShowsHorizontalScrollIndicator:YES];
        }
        if (restoreVertical) {
            [scrollview setShowsVerticalScrollIndicator:YES];
        }
    }

    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width, lowestPoint);
}

- (void)RWHorizontalContentSizeToFit {
    UIScrollView *scrollview = self;
    CGFloat rightMostPoint = 0.0;

    BOOL restoreHorizontal = NO;
    BOOL restoreVertical = NO;

    if ([scrollview respondsToSelector:@selector(setShowsHorizontalScrollIndicator:)] && [scrollview respondsToSelector:@selector(setShowsVerticalScrollIndicator:)]) {
        if ([scrollview showsHorizontalScrollIndicator]) {
            restoreHorizontal = YES;
            [scrollview setShowsHorizontalScrollIndicator:NO];
        }
        if ([scrollview showsVerticalScrollIndicator]) {
            restoreVertical = YES;
            [scrollview setShowsVerticalScrollIndicator:NO];
        }
    }
    for (UIView *subView in scrollview.subviews) {
        if (!subView.hidden) {
            CGFloat maxX = CGRectGetMaxX(subView.frame);
            if (maxX > rightMostPoint) {
                rightMostPoint = maxX;
            }
        }
    }
    if ([scrollview respondsToSelector:@selector(setShowsHorizontalScrollIndicator:)] && [scrollview respondsToSelector:@selector(setShowsVerticalScrollIndicator:)]) {
        if (restoreHorizontal) {
            [scrollview setShowsHorizontalScrollIndicator:YES];
        }
        if (restoreVertical) {
            [scrollview setShowsVerticalScrollIndicator:YES];
        }
    }

    scrollview.contentSize = CGSizeMake(rightMostPoint, scrollview.frame.size.height);
}


@end
