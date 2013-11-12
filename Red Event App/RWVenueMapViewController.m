//
//  RWVenueViewController.m
//  Jule App
//
//  Created by Thorbjørn Steen on 11/7/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWVenueMapViewController.h"
#import "RWVenueVM.h"

@interface RWVenueMapViewController ()

@end

@implementation RWVenueMapViewController{
	
    RWVenueVM *_model;
    GMSMarker *myMarker;
}

- (id)initWithName:(NSString *)name venueid:(int)venueid
{
    self = [super initWithName:name];
    if (self) {
        _model = [_db.Venues getVMFromId:venueid];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	int zoom = [_page getIntegerFromNode:[RWPAGE ZOOM]];
		
    super.mapView.camera = [GMSCameraPosition cameraWithLatitude:_model.latitude longitude:_model.longitude zoom:zoom];
	
    ((GMSMapView *) super.mapView).myLocationEnabled = YES;
	
    GMSMarker *venueMarker = [[GMSMarker alloc] init];
    venueMarker.position = CLLocationCoordinate2DMake(_model.latitude, _model.longitude);
    venueMarker.title = _model.title;
    venueMarker.map = (GMSMapView *) super.mapView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
