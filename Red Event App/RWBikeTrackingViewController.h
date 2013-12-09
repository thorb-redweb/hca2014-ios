//
//  RWBikeTrackingViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 12/3/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"
#import "RWBikeTracker.h"


@interface RWBikeTrackingViewController : RWBaseViewController <RWDelegate_BikeTracker>

@property (weak, nonatomic) IBOutlet UILabel *lblTopSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblTopSpeedData;
@property (weak, nonatomic) IBOutlet UILabel *lblAverageSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblAverageSpeedData;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceData;
@property (weak, nonatomic) IBOutlet UILabel *lblTrackerRunning;

@property (weak, nonatomic) IBOutlet UIButton *btnTrackerActivation;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

enum RWState {PRELAUNCH = 0,RUNNING = 1,STOPPED = 2};

- (id)initWithPage:(RWXmlNode *)page;

-(IBAction)handleTrackerButtonAccordingToState;

@end
