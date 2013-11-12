//
//  RWSessionMapViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/26/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "RWSessionMapViewController.h"
#import "RWAppDelegate.h"
#import "RWDbInterface.h"

#import "RWSessionVM.h"

@interface RWSessionMapViewController ()

@end

@implementation RWSessionMapViewController {
    RWSessionVM *_model;
    CLLocation *myLocation;
    GMSMarker *myMarker;

    BOOL firstLoadOfMyLocation;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil sessionid:(int)sessionid name:(NSString *)name {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil name:name];
    if (self) {
        _model = [_db.Sessions getVMFromId:sessionid];

        firstLoadOfMyLocation = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    int zoom = [_page getIntegerFromNode:[RWPAGE ZOOM]];

    _mapView.camera = [GMSCameraPosition cameraWithLatitude:_model.latitude longitude:_model.longitude zoom:zoom];

    ((GMSMapView *) _mapView).myLocationEnabled = YES;

    GMSMarker *venueMarker = [[GMSMarker alloc] init];
    venueMarker.position = CLLocationCoordinate2DMake(_model.latitude, _model.longitude);
    venueMarker.title = _model.venue;
    venueMarker.snippet = @"Next event at 5:00";
    venueMarker.map = (GMSMapView *) _mapView;

    [_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [_mapView removeObserver:self forKeyPath:@"myLocation"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]]) {
        myLocation = ((GMSMapView *) _mapView).myLocation;

        if (firstLoadOfMyLocation) {
            CLLocationCoordinate2D my2DLocation = CLLocationCoordinate2DMake(myLocation.coordinate.latitude, myLocation.coordinate.longitude);
            GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:my2DLocation coordinate:my2DLocation];

            bounds = [bounds includingCoordinate:my2DLocation];
            for (GMSMarker *marker in ((GMSMapView *) _mapView).markers) {
                bounds = [bounds includingCoordinate:marker.position];
            }

            [((GMSMapView *) _mapView) animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:45.0f]];

            firstLoadOfMyLocation = NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
