//
//  RWSessionMapViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/26/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "RWBaseViewController.h"

@interface RWSessionMapViewController : RWBaseViewController <UITabBarDelegate>

@property(weak, nonatomic) IBOutlet UIView *mapViewOnScreen;
@property(weak, nonatomic) IBOutlet GMSMapView *mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil sessionid:(int)sessionid name:(NSString *)name;

@end
