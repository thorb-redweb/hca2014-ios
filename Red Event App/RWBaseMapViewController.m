//
//  RWBaseMapViewController.m
//  Jule App
//
//  Created by Thorbjørn Steen on 11/7/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWBaseMapViewController.h"
#import "UIColor+RWColor.h"

@interface RWBaseMapViewController ()

@end

@implementation RWBaseMapViewController{
    BOOL firstLoadOfMyLocation;
	
    GMSPolyline *route;
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWBaseMapView" bundle:nil page:page];
    if (self) {
        firstLoadOfMyLocation = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.markers = [[NSMutableArray alloc] init];

    [self setAppearance];
	[self setText];
	
    _mapView.delegate = self;
	
	
	if(![_page hasChild:[RWPAGE RETURNBUTTON]] ||
	   ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
		[_btnBack RWsetHeightAsConstraint:0.0];
		[_btnBack setHidden:YES];
	}	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	[_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

	[helper.button setBackButtonStyle:_btnBack];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]];
	
	if(!backButtonHasBackgroundImage){
		[helper setButtonText:_btnBack textName:[RWTEXT MAPVIEW_BACKBUTTON] defaultText:[RWDEFAULTTEXT MAPVIEW_BACKBUTTON]];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	@try{
		[_mapView removeObserver:self forKeyPath:@"myLocation"];
	}
	@catch (id anException) {
		//Hopefully this will only be thrown in the instances where the observer haven't yet been added
	}
}

- (void)addMarkerToMapView:(GMSMarker *)marker {
    [_markers addObject:marker];
    marker.map = _mapView;
}

-(IBAction)btnBackClicked{
    [_app.navController popPage];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
	NSArray *snippets = [marker.snippet componentsSeparatedByString:@"//"];
	
	RWXmlNode *childPage = [[_xml getPage:_childname] deepClone];
	[childPage addNodeWithName:[RWPAGE SESSIONID] value:snippets[1]];
	[_app.navController pushViewWithPage:childPage];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]]) {
        if (firstLoadOfMyLocation) {
            [self alignCameraBoundsWithMarkers];
			
            firstLoadOfMyLocation = NO;
        }
    }
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
	RWInfoWindow *view = [[[NSBundle mainBundle] loadNibNamed:@"RWInfoWindow" owner:self options:nil] objectAtIndex:0];
	[view setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"MapInfoWindow"]]];
	//set the content
	view.lblTitle.text = marker.title;
	NSArray *snippets = [marker.snippet componentsSeparatedByString:@"//"];
	view.lblBody.text = snippets[0];
	return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)retrieveDirections:(NSDictionary *)json {
    if(route) {
        route.map = nil;
    }

    if([json[@"status"] isEqual:@"OK"]){
        NSDictionary *routes = json[@"routes"][0];

        //Match map to bounds
        NSDictionary *bounds = routes[@"bounds"];
        NSDictionary *northeast = bounds[@"northeast"];
        NSDictionary *southwest = bounds[@"southwest"];
        [self setMapCameraForJsonCoordinatesNortheast:northeast southWest:southwest];

        //Get the individual steps of the path
        NSDictionary *legs = routes[@"legs"][0];
        NSArray *steps = legs[@"steps"];

        //Create line to place on map
        GMSMutablePath *path = [GMSMutablePath path];

        NSDictionary *startLocation = legs[@"start_location"];
        [path addCoordinate:CLLocationCoordinate2DMake(((NSString *)startLocation[@"lat"]).doubleValue,((NSString *)startLocation[@"lng"]).doubleValue)];

        for(int i = 0; i < steps.count; i++){
            NSDictionary *step = steps[i];
            NSDictionary *endLocation = step[@"end_location"];
            [path addCoordinate:CLLocationCoordinate2DMake(((NSString *)endLocation[@"lat"]).doubleValue,((NSString *)endLocation[@"lng"]).doubleValue)];
        }

        //Add line to map
        route = [GMSPolyline polylineWithPath:path];
        route.strokeColor = [UIColor colorWithHexString:@"#e5007d"];
        route.strokeWidth = 3;
        route.map = _mapView;
    }
    else {
        //TODO implement error
        //errorOccured("API call failed");
    }
}

- (void)setMapCameraForJsonCoordinatesNortheast:(NSDictionary *)northEast southWest:(NSDictionary *)southWest {
    CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake(((NSString *) northEast[@"lat"]).doubleValue,((NSString *) northEast[@"lng"]).doubleValue);
    CLLocationCoordinate2D loc2 = CLLocationCoordinate2DMake(((NSString *) southWest[@"lat"]).doubleValue,((NSString *) southWest[@"lng"]).doubleValue);
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:loc1 coordinate:loc2];
    [self setMapCameraForBounds:bounds];
}

- (void)alignCameraBoundsWithMarkers {
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];;
    if(self.mapView.myLocation){
        bounds = [bounds includingCoordinate:self.mapView.myLocation.coordinate];
    }
    for (GMSMarker *marker in _markers) {
        bounds = [bounds includingCoordinate:marker.position];
    }

    [self setMapCameraForBounds:bounds];
}

- (void)setMapCameraForBounds:(GMSCoordinateBounds *)bounds{
    GMSCameraPosition *camera = [self.mapView cameraForBounds:bounds insets:UIEdgeInsetsMake(24, 24, 24, 24)];
    self.mapView.camera = camera;
}

- (void)errorOccured:(NSString *)errorMessage {
    //TODO implement later
}


@end
