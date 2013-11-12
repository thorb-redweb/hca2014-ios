//
//  RWMainViewController.h
//  Jule App
//
//  Created by Thorbjørn Steen on 11/6/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWMainViewController : UIViewController;

@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
@property (weak, nonatomic) IBOutlet UIImageView *logobar;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;

@property (weak, nonatomic) UIViewController *childView;

-(id)initWithStartPage:(RWNode *)startPage;

- (void)replaceMainViewWith:(UIViewController *)newViewController;

@end
