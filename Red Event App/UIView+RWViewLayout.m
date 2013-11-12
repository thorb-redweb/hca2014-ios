//
//  UIView+RWView.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/12/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

@implementation UIView (RWViewLayout)

- (void)RWsetHeightAsConstraint:(float)height {
    UIView *view = self;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
    [view addConstraints:[NSArray arrayWithObject:heightConstraint]];
}

- (void)RWsetWidthAsConstraint:(float)width {
    UIView *view = self;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
    [view addConstraints:[NSArray arrayWithObject:heightConstraint]];
}

- (void)RWsetChildHeightAsConstraintWithMultiplier:(float)multiplier view1:(UIView *)view1 view2:(UIView *)view2 {
    UIView *parentView = self;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeHeight multiplier:multiplier constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:heightConstraint]];
}

- (void)RWsetChildHWidthAsConstraintWithMultiplier:(float)multiplier view1:(UIView *)view1 view2:(UIView *)view2 {
    [self RWsetChildHWidthAsConstraintWithMultiplier:multiplier view1:view1 view2:view2 relatedBy:NSLayoutRelationEqual];
}

- (void)RWsetChildHWidthAsConstraintWithMultiplier:(float)multiplier view1:(UIView *)view1 view2:(UIView *)view2 relatedBy:(NSLayoutRelation)relatedBy {
    UIView *parentView = self;
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeWidth relatedBy:relatedBy toItem:view2 attribute:NSLayoutAttributeWidth multiplier:multiplier constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:widthConstraint]];
}

- (void)RWpinChildToBottom:(UIView *)childView {
    UIView *parentView = self;
    NSLayoutConstraint *pinConstraint = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pinConstraint]];
}

- (void)RWpinChildToLeading:(UIView *)childView {
    UIView *parentView = self;
    NSLayoutConstraint *pinConstraint = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pinConstraint]];
}

- (void)RWpinChildToTrailing:(UIView *)childView {
    UIView *parentView = self;
    NSLayoutConstraint *pinConstraint = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pinConstraint]];
}

- (void)RWpinChildToSides:(UIView *)childView {
    UIView *parentView = self;
    NSLayoutConstraint *pintrailingConstraint = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pintrailingConstraint]];
    NSLayoutConstraint *pinleadingConstraint = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pinleadingConstraint]];
}

- (void)RWpinChildToTop:(UIView *)childView {
    UIView *parentView = self;
    NSLayoutConstraint *pinConstraint = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pinConstraint]];
}

- (void)RWpinChildToTop:(UIView *)childView constant:(int)constant{
    UIView *parentView = self;
    NSLayoutConstraint *pinConstraint = [NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:constant];
    [parentView addConstraints:[NSArray arrayWithObject:pinConstraint]];
}

- (void)RWpinChildrenTogetherWithTopChild:(UIView *)topView BottomChild:(UIView *)bottomView {
    UIView *parentView = self;
    NSLayoutConstraint *pinConstraint = [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pinConstraint]];
}

- (void)RWpinChildrenTogetherWithLeftChild:(UIView *)leftView RightChild:(UIView *)rightView {
    UIView *parentView = self;
    NSLayoutConstraint *pinConstraint = [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
    [parentView addConstraints:[NSArray arrayWithObject:pinConstraint]];
}

- (void)RWpinChildrenHeightsWithTopChild:(UIView *)topView BottomChild:(UIView *)bottomView multiplier:(float)multiplier constant:(float)constant {
    UIView *parentView = self;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:bottomView attribute:NSLayoutAttributeHeight multiplier:multiplier constant:constant];
    [parentView addConstraints:[NSArray arrayWithObject:heightConstraint]];
}

@end
