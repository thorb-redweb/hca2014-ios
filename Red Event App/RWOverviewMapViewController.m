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


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithPage:page];
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
	
    super.mapView.camera = [GMSCameraPosition cameraWithLatitude:standardLatitude longitude:standardLongitude zoom:standardZoom];
	
    ((GMSMapView *) super.mapView).myLocationEnabled = YES;
	
    for (RWVenueVM *venue in venueList) {
        GMSMarker *venueMarker = [[GMSMarker alloc] init];
        venueMarker.position = CLLocationCoordinate2DMake(venue.latitude, venue.longitude);
		venueMarker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        venueMarker.title = venue.title;
        venueMarker.snippet = @"Next event at 5:00";
        venueMarker.map = (GMSMapView *) super.mapView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
