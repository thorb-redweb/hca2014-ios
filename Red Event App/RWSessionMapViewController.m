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

    [self setupViews];
}

- (void)setupViews{
    [self setupDirectionsButtons];
    [self setupMapView];
}

- (void)setupDirectionsButtons{
    [self setupButton:self.btnDriving];
    [self setupButton:self.btnBiking];
    [self setupButton:self.btnWalking];
}

- (void)setupButton:(UIButton *)button {
    button.hidden = NO;
    [button addTarget:self action:@selector(getDirections:) forControlEvents:UIControlEventTouchUpInside];

    button.clipsToBounds = YES;
    button.layer.cornerRadius = button.frame.size.height / 2.0f;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];

    UIImage *image = [button.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:image forState:UIControlStateNormal];
    button.tintColor = [UIColor whiteColor];
}

- (void)setupMapView{
    int zoom = [_page getIntegerFromNode:[RWPAGE ZOOM]];

    super.mapView.camera = [GMSCameraPosition cameraWithLatitude:_model.latitude longitude:_model.longitude zoom:zoom];

    super.mapView.myLocationEnabled = YES;

    GMSMarker *sessionMarker = [[GMSMarker alloc] init];
    sessionMarker.position = CLLocationCoordinate2DMake(_model.latitude, _model.longitude);
    sessionMarker.title = _model.title;
    NSString *snippet = [NSString stringWithFormat:@"%@",_model.startTime];
    snippet = [NSString stringWithFormat:@"%@//%@",snippet, _model.sessionid];
    sessionMarker.snippet = snippet;
    [self addMarkerToMapView:sessionMarker];

    sessionMarker.icon = _model.typeIcon;

    [self alignCameraBoundsWithMarkers];
}

- (void)getDirections:(UIButton *)button{
    NSString *travelMode = @"driving";
    if(button == self.btnBiking){
        travelMode = @"bicycling";
    }
    else if(button == self.btnWalking){
        travelMode = @"walking";
    }

    NSString *origin = [NSString stringWithFormat:@"%f,%f", self.mapView.myLocation.coordinate.latitude, self.mapView.myLocation.coordinate.longitude];
    NSString *destination = [NSString stringWithFormat:@"%f,%f", _model.latitude, _model.longitude];
    [_sv getDirections:self travelMode:travelMode origin: origin destination: destination];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
