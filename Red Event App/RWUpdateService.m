//
//  RWUpdateService.m
//  hca2014
//
//  Created by Thorbjørn Steen on 3/6/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWUpdateService.h"
#import "RWAppDelegate.h"

@implementation RWUpdateService{
	UIApplication *_application;
	RWAppDelegate *_app;
	
	NSTimer *_timer;
	UIBackgroundTaskIdentifier _backgroundTask;
}

-(id)init{
	if(self = [super init]){
		_application = [UIApplication sharedApplication];
		_app = [_application delegate];
	}
	return self;
}

-(void)start{
    NSLog(@"UpdateService starting");
	_timer = [NSTimer scheduledTimerWithTimeInterval:5*60 target:self selector:@selector(startUpdate) userInfo:Nil repeats:YES];
	_backgroundTask = [_application beginBackgroundTaskWithExpirationHandler:^{
		[_application endBackgroundTask:_backgroundTask];
		_backgroundTask = UIBackgroundTaskInvalid;
	}];
	[self startUpdate];
}

-(void)stop{
    NSLog(@"UpdateService stopping");
	[_timer invalidate];
	_timer = nil;
	if(_backgroundTask != UIBackgroundTaskInvalid){
		[_application endBackgroundTask:_backgroundTask];
		_backgroundTask = UIBackgroundTaskInvalid;
	}
    NSLog(@"UpdateService stopped");
}

-(void)startUpdate{
    NSLog(@"Check for updates");
	NSDate *fiveMinuteBack = [[NSDate date] dateByAddingTimeInterval:-(5*60)];
	if([_app.lastUpdated compare:fiveMinuteBack] == NSOrderedAscending){
	   [_app.sv updateDatabase:self];
	}
	else{
        NSLog(@"No update; last update too close to current time");
	}
}

- (void)continueAfterUpdate {
	_app.lastUpdated = [NSDate date];
    NSLog(@"Update finished");
}


@end
