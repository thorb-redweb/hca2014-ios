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

- (void)pushViewFromTab:(RWXmlNode *)tabPage;

- (void)pushViewWithParameters:(NSDictionary *)parameters;

- (void)pushViewController:(UIViewController *)newViewController;

- (void)popViewController;

+ (UIViewController *)getViewControllerFromDictionary:(NSDictionary *)parameters;

@end
