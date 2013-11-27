//
//  RWSplashViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/26/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWHandler_DumpDatabase.h"
#import "RWHandler_UpdateDatabase.h"

@interface RWSplashViewController : UIViewController <RWDelegate_DumpDatabase, RWDelegate_UpdateDatabase, UIAlertViewDelegate>

@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(weak, nonatomic) IBOutlet UILabel *topActivityLabel;
@property(weak, nonatomic) IBOutlet UILabel *bottomActivityLabel;
@property(weak, nonatomic) IBOutlet UIView *updateBackgroundBox;
@property(weak, nonatomic) IBOutlet UIButton *btnBackground;

@property(weak, nonatomic) UITabBar *venuePickerDelegate;

@end
