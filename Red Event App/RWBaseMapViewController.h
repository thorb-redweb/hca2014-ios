//
//  RWBaseMapViewController.h
//  Jule App
//
//  Created by Thorbjørn Steen on 11/7/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "RWBaseViewController.h"

@interface RWBaseMapViewController : RWBaseViewController

@property(weak, nonatomic) IBOutlet UIView *mainView;
@property(weak, nonatomic) IBOutlet GMSMapView *mapView;
@property(weak, nonatomic) IBOutlet UIButton *btnBack;


- (id)initWithName:(NSString *)name;

-(IBAction)btnBackClicked;
@end
