//
//  RWSwipeViewController.h
//  Jule App
//
//  Created by Thorbjørn Steen on 11/4/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"
@class RWNode;

@interface RWSwipeViewController : RWBaseViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (id)initWithName:(NSString *)name;

@end
