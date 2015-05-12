//
//  RWBaseMapViewController.m
//  Jule App
//
//  Created by Thorbjørn Steen on 11/7/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWBaseMapViewController.h"

@interface RWBaseMapViewController ()

@end

@implementation RWBaseMapViewController{
    BOOL firstLoadOfMyLocation;
	
    CLLocation *myLocation;
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
        myLocation = ((GMSMapView *) _mapView).myLocation;
		
        if (firstLoadOfMyLocation) {
            CLLocationCoordinate2D my2DLocation = CLLocationCoordinate2DMake(myLocation.coordinate.latitude, myLocation.coordinate.longitude);
            GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:my2DLocation coordinate:my2DLocation];
			
            bounds = [bounds includingCoordinate:my2DLocation];
            for (GMSMarker *marker in _markers) {
                bounds = [bounds includingCoordinate:marker.position];
            }
			
            [((GMSMapView *) _mapView) animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:45.0f]];
			
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

@end
