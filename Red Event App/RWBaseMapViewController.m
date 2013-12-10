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
	}	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	[_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK MAPVIEW_BACKGROUNDIMAGE] localColorName:[RWLOOK MAPVIEW_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper setButtonBackgroundImageOrColor:_btnBack localImageName:[RWLOOK MAPVIEW_BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK MAPVIEW_BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	[helper setButtonImageFromLocalSource:_btnBack localName:[RWLOOK MAPVIEW_BACKBUTTONICON] forState:UIControlStateNormal];
	[helper setButtonTitleColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK MAPVIEW_BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btnBack forState:UIControlStateNormal localSizeName:[RWLOOK MAPVIEW_BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK MAPVIEW_BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK MAPVIEW_BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btnBack forState:UIControlStateNormal localName:[RWLOOK MAPVIEW_BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK MAPVIEW_BACKBUTTONBACKGROUNDIMAGE]];
	
	if(!backButtonHasBackgroundImage){
		[helper setButtonText:_btnBack textName:[RWTEXT MAPVIEW_BACKBUTTON] defaultText:[RWDEFAULTTEXT MAPVIEW_BACKBUTTON]];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
    [_mapView removeObserver:self forKeyPath:@"myLocation"];
}

-(IBAction)btnBackClicked{
    [_app.navController popPage];
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

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
	RWInfoWindow *view = [[[NSBundle mainBundle] loadNibNamed:@"RWInfoWindow" owner:self options:nil] objectAtIndex:0];
	view.lblTitle.text = marker.title;
	view.lblBody.text = @"Working";
	return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
