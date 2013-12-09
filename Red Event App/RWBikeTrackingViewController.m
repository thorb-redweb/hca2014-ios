//
//  RWBikeTrackingViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 12/3/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWBikeTrackingViewController.h"
#import "RWBikeTracker.h"

@interface RWBikeTrackingViewController ()

@end

@implementation RWBikeTrackingViewController{
    RWBikeTracker *_bikeTracker;
    enum RWState _state;
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWBikeTrackingViewController" bundle:nil page:page];
    if (self) {
        _bikeTracker = [[RWBikeTracker alloc] initWithDelegate:self];
        _state = PRELAUNCH;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self setAppearance];
    [self setText];
}

-(void)setAppearance{

}

-(void)setText{
    RWTextHelper *helper = _textHelper;
    [helper setText:_lblAverageSpeedLabel textName:[RWTEXT BIKETRACKING_AVERAGESPEED] defaultText:[RWDEFAULTTEXT BIKETRACKING_AVERAGESPEED]];
    [helper setText:_lblDistanceLabel textName:[RWTEXT BIKETRACKING_DISTANCE] defaultText:[RWDEFAULTTEXT BIKETRACKING_DISTANCE]];
    [helper setText:_lblTopSpeedLabel textName:[RWTEXT BIKETRACKING_TOPSPEED] defaultText:[RWDEFAULTTEXT BIKETRACKING_TOPSPEED]];
    [helper setText:_lblTrackerRunning textName:[RWTEXT BIKETRACKING_STOPPED] defaultText:[RWDEFAULTTEXT BIKETRACKING_STOPPED]];
    [helper setButtonText:_btnTrackerActivation textName:[RWTEXT BIKETRACKING_STARTBUTTON] defaultText:[RWDEFAULTTEXT BIKETRACKING_STARTBUTTON]];
    [helper setButtonText:_btnBack textName:[RWTEXT BIKETRACKING_BACKBUTTON] defaultText:[RWDEFAULTTEXT BIKETRACKING_BACKBUTTON]];
}

- (IBAction)handleTrackerButtonAccordingToState {
    switch (_state){
        case PRELAUNCH:
            [self startBikeTracker];
            break;
        case RUNNING:
            [self stopBikeTracker];
            break;
        case STOPPED:
            break;
    }
}

- (void)startBikeTracker{
    [_bikeTracker startTracking];
    [_textHelper setText:_lblTrackerRunning textName:[RWTEXT BIKETRACKING_RUNNING] defaultText:[RWDEFAULTTEXT BIKETRACKING_RUNNING]];
    [_textHelper setButtonText:_btnTrackerActivation textName:[RWTEXT BIKETRACKING_STOPBUTTON] defaultText:[RWDEFAULTTEXT BIKETRACKING_STOPBUTTON]];

    _lblAverageSpeedData.text = @"0.0 km/t";
    _lblTopSpeedData.text = @"0.0 km/t";
    _lblDistanceData.text = @"0 m";

    _state = RUNNING;
}

- (void)stopBikeTracker{
    [_bikeTracker stopTracking];
    [_textHelper setText:_lblTrackerRunning textName:[RWTEXT BIKETRACKING_STOPPED] defaultText:[RWDEFAULTTEXT BIKETRACKING_STOPPED]];
    [_textHelper setButtonText:_btnTrackerActivation textName:[RWTEXT BIKETRACKING_CONTINUEBUTTON] defaultText:[RWDEFAULTTEXT BIKETRACKING_CONTINUEBUTTON]];
    [_btnTrackerActivation setHidden:true];
    _state = STOPPED;
}

- (void)averageSpeedUpdated:(NSString *)averageSpeed {
    _lblAverageSpeedData.text = [NSString stringWithFormat: @"%@ km/t", averageSpeed];
}

-(void)topSpeedUpdated:(NSString *)topSpeed {
    _lblTopSpeedData.text = [NSString stringWithFormat: @"%@ km/t", topSpeed];
}

-(void)distanceUpdated:(NSString *)distance {
    _lblDistanceData.text = [NSString stringWithFormat: @"%@ m", distance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
