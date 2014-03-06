//
//  UIView+RWView.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/12/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RWViewLayout)

- (void)RWsetHeightAsConstraint:(float)height;

- (void)RWsetWidthAsConstraint:(float)width;

- (void)RWsetChildHeightAsConstraintWithMultiplier:(float)multiplier view1:(UIView *)view1 view2:(UIView *)view2;

- (void)RWsetChildHWidthAsConstraintWithMultiplier:(float)multiplier view1:(UIView *)view1 view2:(UIView *)view2;

- (void)RWsetChildHWidthAsConstraintWithMultiplier:(float)multiplier view1:(UIView *)view1 view2:(UIView *)view2 relatedBy:(NSLayoutRelation)relatedBy;

- (void)RWpinChildToBottom:(UIView *)childView;

- (void)RWpinChildToLeading:(UIView *)childView;

- (void)RWpinChildToLeading:(UIView *)childView constant:(int)constant;

- (void)RWpinChildToTrailing:(UIView *)childView;

- (void)RWpinChildToSides:(UIView *)childView;

- (void)RWpinChildToEdges:(UIView *)childView padding:(int)padding;

- (void)RWpinChildToTop:(UIView *)childView;

- (void)RWpinChildToTop:(UIView *)childView constant:(int)constant;

- (void)RWpinChildrenTogetherWithTopChild:(UIView *)topView BottomChild:(UIView *)bottomView;

- (void)RWpinChildrenTogetherWithLeftChild:(UIView *)leftView RightChild:(UIView *)rightView;

- (void)RWpinChildrenHeightsWithTopChild:(UIView *)topView BottomChild:(UIView *)bottomView multiplier:(float)multiplier constant:(float)constant;

@end
