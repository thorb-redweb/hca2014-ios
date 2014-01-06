//
// Created by Thorbjørn Steen on 12/3/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#import "MyLog.h"

#import "RWBikeTracker.h"

static const int localLogLevel = LOG_LEVEL_DEBUG;

@implementation RWBikeTracker {
    NSMutableArray *_locations;
    double _distance;
    bool _newReadingSinceLastDistanceCheck;
    double _averageSpeed;
    bool _newReadingSinceLastAverageSpeedCheck;
    double _topSpeed;
    bool _newReadingSinceLastTopSpeedCheck;

    bool _deferringUpdates;
}

- (id)initWithDelegate:(id)delegate{
    if(self = [super init]){
		if(localLogLevel != LOG_LEVEL_GLOBAL){
			ddLogLevel = localLogLevel;
		}
		
        _delegate = delegate;
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;

        _locations = [[NSMutableArray alloc] init];

        _deferringUpdates = false;
    }
    return self;
}

-(void)insertTestData{
    CLLocationCoordinate2D coorA;
    coorA.latitude = 55.38442;
    coorA.longitude = 10.44131;
    NSDate *timeStamp = [[NSDate alloc] init];
    NSDate *timeStampA = [timeStamp dateByAddingTimeInterval:-(60*2)];
    CLLocation *locationA = [[CLLocation alloc] initWithCoordinate:coorA altitude:5 horizontalAccuracy:5 verticalAccuracy:5 timestamp:timeStampA];
    [_locations addObject:locationA];

//    CLLocationCoordinate2D coorB;
//    coorB.latitude = 0.38442;
//    coorB.longitude = 10.44131;
//    NSDate *timeStampB = [timeStamp dateByAddingTimeInterval:-(60*4)];
//    CLLocation *locationB = [[CLLocation alloc] initWithCoordinate:coorB altitude:5 horizontalAccuracy:500 verticalAccuracy:5 timestamp:timeStampB];
//    [_locations addObject:locationB];
}

-(void)startTracking{
//    [self insertTestData];

    [_locationManager startUpdatingLocation];
}

-(void)stopTracking{
    [_locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for(CLLocation *newLocation in locations){
        if(newLocation.horizontalAccuracy <= 30.0){
            if(_locations.count >= 1){
                CLLocation *lastLoc = _locations.lastObject;
                double lastLocDistance = [self calculateDistanceBetweenTwoLocations:lastLoc secondLocation:newLocation];
                if(lastLocDistance >= 100.0)
                {
                    [_locations addObject:newLocation];
					DDLogDebug(@"Location added: %@", newLocation.description);

                    _newReadingSinceLastTopSpeedCheck = true;
                    _newReadingSinceLastAverageSpeedCheck = true;
                    _newReadingSinceLastDistanceCheck = true;

                    [_delegate topSpeedUpdated:[self getTopSpeed]];
                    [_delegate averageSpeedUpdated:[self getAverageSpeed]];
                    [_delegate distanceUpdated:[self getTotalDistanceTravelled]];
                }
				else{
					DDLogVerbose(@"Location dropped: %@",newLocation.description);
				}
            }
            else {
                [_locations addObject:newLocation];
				DDLogDebug(@"Location added: %@", newLocation.description);
            }

            if(!_deferringUpdates){
                CLLocationDistance distance = 100;
                NSTimeInterval time = 15;
                [_locationManager allowDeferredLocationUpdatesUntilTraveled:distance timeout:time];

                _deferringUpdates = true;
            }
        }


    }
}

-(NSString *)getTopSpeed{
    if(_newReadingSinceLastTopSpeedCheck){
        CLLocation *lastLoc = nil;
        _topSpeed = 0.0;
        for(CLLocation *loc in _locations){
            if(lastLoc != nil){
                long startTime = lastLoc.timestamp.timeIntervalSince1970;
                long stopTime = loc.timestamp.timeIntervalSince1970;
                double elapsedTime = stopTime - startTime;
                double timeInHours = elapsedTime / (60.0 * 60.0);
                if(timeInHours != 0){
                    double distance = [self calculateDistanceBetweenTwoLocations:lastLoc secondLocation:loc];
                    double distanceInKm = distance / 1000;

                    double speed = distanceInKm/timeInHours;

                    if(speed > _topSpeed){
                        _topSpeed = speed;
                    }
                }
            }
            lastLoc = loc;
        }
        _newReadingSinceLastTopSpeedCheck = false;
    }
    return [NSString stringWithFormat:@"%f",_topSpeed];
}

-(NSString *)getAverageSpeed{
    if(_newReadingSinceLastAverageSpeedCheck){
        if(_newReadingSinceLastDistanceCheck){
            [self getTotalDistanceTravelled];
        }

        long startTime = ((CLLocation *)_locations[0]).timestamp.timeIntervalSince1970;
        long stopTime = ((CLLocation *)_locations[_locations.count-1]).timestamp.timeIntervalSince1970;
        double elapsedTime = stopTime - startTime;
        double timeInHours = elapsedTime / (60.0 * 60.0);
        if(timeInHours == 0.0){
            return @"0.0";
        }

        double distanceInKm = _distance / 1000;
        _averageSpeed =  distanceInKm/timeInHours;
        _newReadingSinceLastAverageSpeedCheck = false;
    }
    return [NSString stringWithFormat:@"%f",_averageSpeed];
}

-(NSString *)getTotalDistanceTravelled{
    if(_newReadingSinceLastDistanceCheck){
        CLLocation *lastLoc = nil;
        _distance = 0.0;
        for (CLLocation *loc in _locations){
            if (lastLoc != nil){
                _distance += [self calculateDistanceBetweenTwoLocations:lastLoc secondLocation:loc];
            }
            lastLoc = loc;
        }
        _newReadingSinceLastDistanceCheck = false;
    }
    return [NSString stringWithFormat:@"%f",_distance];
}

-(double)calculateDistanceBetweenTwoLocations:(CLLocation *) a secondLocation:(CLLocation *) b{
    double pk = (180/3.14169);
    double lat_a = a.coordinate.latitude;
    double lng_a = a.coordinate.longitude;
    double lat_b = b.coordinate.latitude;
    double lng_b = b.coordinate.longitude;

    double a1 = lat_a / pk;
    double a2 = lng_a / pk;
    double b1 = lat_b / pk;
    double b2 = lng_b / pk;

    double t1 = cos(a1)*cos(a2)*cos(b1)*cos(b2);
    double t2 = cos(a1)*sin(a2)*cos(b1)*sin(b2);
    double t3 = sin(a1)*sin(b1);
    double tt = acos(t1 + t2 + t3);

    return 6366000*tt;
}

@end