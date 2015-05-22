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

#import "RWInfoWindow.h"
#import "RWHandler_GetDirections.h"

@interface RWBaseMapViewController : RWBaseViewController <GMSMapViewDelegate, UIGestureRecognizerDelegate, RWDelegate_GetDirections>

@property(weak, nonatomic) IBOutlet UIView *mainView;
@property(weak, nonatomic) IBOutlet GMSMapView *mapView;
@property(weak, nonatomic) IBOutlet UIButton *btnDriving;
@property(weak, nonatomic) IBOutlet UIButton *btnBiking;
@property(weak, nonatomic) IBOutlet UIButton *btnWalking;
@property(weak, nonatomic) IBOutlet UIButton *btnBack;

@property (strong, nonatomic) NSMutableArray *markers;

- (id)initWithPage:(RWXmlNode *)page;

- (void)addMarkerToMapView:(GMSMarker *)marker;

-(IBAction)btnBackClicked;

- (void)setMapCameraForJsonCoordinatesNortheast:(NSDictionary *)northEast southWest:(NSDictionary *)southWest;

- (void)alignCameraBoundsWithMarkers;
@end
