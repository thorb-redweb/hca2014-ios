//
//  RWNewsTickerView2.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/4/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RWXmlNode.h"

@interface RWNewsTickerView2 : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (id)initWithPage:(RWXmlNode *)componentpage;

@end
