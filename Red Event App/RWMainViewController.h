//
//  RWMainViewController.h
//  Jule App
//
//  Created by Thorbjørn Steen on 11/6/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"
#import "RWNavController.h"

@interface RWMainViewController : UIViewController <UITabBarDelegate, UIWebViewDelegate>;

@property (weak, nonatomic) IBOutlet RWNavController *navbar;
@property (weak, nonatomic) IBOutlet UIImageView *logobar;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;

@property (weak, nonatomic) UIViewController *childView;

-(id)initWithStartPage:(RWXmlNode *)startPage;

@end
