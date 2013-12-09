//
//  RWNavigationController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/20/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWXmlNode;
@class RWMainViewController;

@interface RWNavigationController : NSObject

- (void)connectToMainView:(RWMainViewController *)mainViewcontroller;

- (void)pushViewWithPage:(RWXmlNode *)page;

- (void)pushViewWithPage:(RWXmlNode *)page addToBackStack:(bool)addToBackStack;

- (void)pushViewController:(UIViewController *)newViewController addToBackStack:(bool)addToBackStack;

- (void)popViewController;

+ (UIViewController *)getViewControllerFromPage:(RWXmlNode *)parameters;

@end
