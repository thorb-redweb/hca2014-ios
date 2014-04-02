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
#import "RWSessionVM.h"

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
	
	double standardLatitude;
	if([_page hasChild:[RWPAGE LATITUDE]]){
		standardLatitude = [_page getDoubleFromNode:[RWPAGE LATITUDE]];
	}
	else{
		standardLatitude = 55.390641;
	}
	double standardLongitude;
	if([_page hasChild:[RWPAGE LONGITUDE]]){
		standardLongitude = [_page getDoubleFromNode:[RWPAGE LONGITUDE]];
	}
	else {
		standardLongitude = 10.437864;
	}
    float standardZoom;
	if([_page hasChild:[RWPAGE ZOOM]]){
		standardZoom= [_page getFloatFromNode:[RWPAGE ZOOM]];
	}
	else{
		standardZoom = 12;
	}
	
    super.mapView.camera = [GMSCameraPosition cameraWithLatitude:standardLatitude longitude:standardLongitude zoom:standardZoom];
	
    ((GMSMapView *) super.mapView).myLocationEnabled = YES;
	
    for (RWVenueVM *venue in venueList) {
		RWSessionVM *session = [_db.Venues getNextSession:venue.venueid];

		//check if the venue has a next session
		//only if it has should it get a marker
		if(session && !(venue.latitude == 0 && venue.longitude == 0)){
			GMSMarker *venueMarker = [[GMSMarker alloc] init];
			venueMarker.position = CLLocationCoordinate2DMake(venue.latitude, venue.longitude);
			venueMarker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
			venueMarker.title = venue.title;
			
			NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
			NSUInteger sessionDay = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:session.startDatetime];
			NSUInteger currentDay = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:[[NSDate alloc] init]];
			NSString *datetime;
			if (sessionDay == currentDay){
                datetime = [NSString stringWithFormat:@"kl. %@", session.startTime];
            }
            else
            {
                datetime = [NSString stringWithFormat: @"%@ kl. %@", session.startDateDay, session.startTime];
            }
			NSString *snippet = [NSString stringWithFormat:@"Næste event: %@", datetime];
			snippet = [NSString stringWithFormat:@"%@\n%@", snippet, [session title]];
			snippet = [NSString stringWithFormat:@"%@//%@", snippet, session.sessionid];
			venueMarker.snippet = snippet;
			venueMarker.map = (GMSMapView *) super.mapView;
			
			venueMarker.icon = session.typeIcon;
		}
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
