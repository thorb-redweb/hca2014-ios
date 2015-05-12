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
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithPage:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

    int sessionId = [_page getIntegerFromNode:[RWPAGE SESSIONID]];
    _model = [_db.Sessions getVMFromId:sessionId];
    
	int zoom = [_page getIntegerFromNode:[RWPAGE ZOOM]];
	
    super.mapView.camera = [GMSCameraPosition cameraWithLatitude:_model.latitude longitude:_model.longitude zoom:zoom];
	
    ((GMSMapView *) super.mapView).myLocationEnabled = YES;
	
    GMSMarker *sessionMarker = [[GMSMarker alloc] init];
    sessionMarker.position = CLLocationCoordinate2DMake(_model.latitude, _model.longitude);
    sessionMarker.title = _model.title;
	NSString *snippet = [NSString stringWithFormat:@"%@",_model.startTime];
	snippet = [NSString stringWithFormat:@"%@//%@",snippet, _model.sessionid];
	sessionMarker.snippet = snippet;
    [self addMarkerToMapView:sessionMarker];
	
	sessionMarker.icon = _model.typeIcon;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
