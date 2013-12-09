//
// Created by Thorbjørn Steen on 12/3/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class CLLocationManager;
@class CLLocation;

@protocol RWDelegate_BikeTracker <NSObject>
- (void)averageSpeedUpdated:(NSString *)averageSpeed;
- (void)distanceUpdated:(NSString *)distance;
- (void)topSpeedUpdated:(NSString *)topSpeed;
@end

@interface RWBikeTracker : NSObject <CLLocationManagerDelegate>{
    id <RWDelegate_BikeTracker> _delegate;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

- (id)initWithDelegate:(id)delegate;

- (void)startTracking;

- (void)stopTracking;
@end