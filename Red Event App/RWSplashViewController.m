//
//  RWSplashViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/26/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWSplashViewController.h"

#import "RWAppDelegate.h"
#import "RWXMLStore.h"
#import "RWDbInterface.h"
#import "RWServer.h"

#import "RWArticleVM.h"
#import "RWDbArticles.h"

@interface RWSplashViewController ()

@end

@implementation RWSplashViewController {
    RWDbInterface *_db;
    RWServer *_sv;
    RWXMLStore *_xmlDist;

    NSTimeInterval _splashDelay;
	NSTimer *_splashTimer;
	
	UIAlertView *_alertview;

    bool _firstTime;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
        _xmlDist = app.xml;

        _db = app.db;
        _sv = app.sv;

        _firstTime = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [_btnBackground setImage:[UIImage imageNamed:@"splash"] forState:UIControlStateNormal];
    [_btnBackground setImage:[UIImage imageNamed:@"splash"] forState:UIControlStateHighlighted];
	
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appHasEnteredForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self continueAfterUpdate];
//	[self getDataFromServer];
}

- (void)appHasEnteredForeground {
//    if(_firstTime){
//	    [self getDataFromServer];
//        _firstTime = false;
//    }
}

-(void)getDataFromServer{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *dataversion = [prefs objectForKey:@"dataversion"];
    DDLogInfo(@"Current dataversion: %@", dataversion);
    if (!dataversion) {
        _splashDelay = 2.0;
        [self showActivityViews];
        [_sv dumpServer:self];
    }
    else {
        DDLogInfo(@"No need for dump");
        _splashDelay = 5.0;
        [self checkForUpdates];
    }
}

- (void)continueAfterDump {
	DDLogVerbose(@"After dump, check for updates");
    [self checkForUpdates];
}

- (void)checkForUpdates {
    [_sv updateDatabase:self];
}

- (void)continueAfterUpdate {
	DDLogInfo(@"Ready to Continue to Front Page");
    [self hideActivityViews];
	[_btnBackground addTarget:self action:@selector(continueToApp) forControlEvents:UIControlEventTouchUpInside];
    _splashTimer = [NSTimer scheduledTimerWithTimeInterval:_splashDelay target:self selector:@selector(continueToApp:) userInfo:nil repeats:NO];
}

- (void)continueToApp{
	DDLogVerbose(@"Continue to front page");
	[_splashTimer invalidate];
	RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app startNavController];
}

- (void)continueToApp:(NSTimer *)theTimer {
    [self continueToApp];
}

- (void)hideActivityViews {
    [_activityIndicator stopAnimating];
    _topActivityLabel.hidden = YES;
    _bottomActivityLabel.hidden = YES;
    _updateBackgroundBox.hidden = YES;
}

- (void)showActivityViews {
    [_activityIndicator startAnimating];
    _topActivityLabel.hidden = NO;
    _bottomActivityLabel.hidden = NO;
    _updateBackgroundBox.hidden = NO;
}

- (void)errorOccured:(NSString *)errorMessage{
	_alertview = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:@"Der er sket en fejl under hentning af data" delegate:self cancelButtonTitle:@"Prøv igen" otherButtonTitles:@"Afslut app", nil];
	[_alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Prøv igen"])
    {
		[self alertOnClickTryAgain];
    }
    else if([title isEqualToString:@"Afslut app"])
    {
        [self alertOnClickCloseMessage];
    }
}

- (void)alertOnClickTryAgain{
	[self getDataFromServer];
}

- (void)alertOnClickCloseMessage{
	[self hideActivityViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
