//
//  RWOverviewMapViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWOverviewMapViewController.h"

#import "RWAppDelegate.h"
#import "RWVenueVM.h"

@interface RWOverviewMapViewController ()

@end

@implementation RWOverviewMapViewController {
    CLLocation *myLocation;
    GMSMarker *myMarker;

    BOOL firstLoadOfMyLocation;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil name:name];
    if (self) {
        firstLoadOfMyLocation = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *venueList = [_db.Venues getVMList];

    double standardLatitude = [_page getDoubleFromNode:[RWPAGE LATITUDE]];
    double standardLongitude = [_page getDoubleFromNode:[RWPAGE LONGITUDE]];
    float standardZoom = [_page getFloatFromNode:[RWPAGE ZOOM]];

    _mapView.camera = [GMSCameraPosition cameraWithLatitude:standardLatitude longitude:standardLongitude zoom:standardZoom];

    _mapView.myLocationEnabled = YES;

    for (RWVenueVM *venue in venueList) {
        GMSMarker *venueMarker = [[GMSMarker alloc] init];
        venueMarker.position = CLLocationCoordinate2DMake(venue.latitude, venue.longitude);
        venueMarker.title = venue.title;
        venueMarker.snippet = @"Next event at 5:00";
        venueMarker.map = (GMSMapView *) _mapView;
    }

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
