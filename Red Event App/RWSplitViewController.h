//
//  RWFrontPageViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWSplitViewController : RWBaseViewController

@property(weak, nonatomic) IBOutlet UIView *vwMainTopPart;
@property(weak, nonatomic) IBOutlet UIView *vwMainBottomPart;

- (id)initWithName:(NSString *)name;

@end
