//
//  RWPushMessageAutoSubscriberViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWPushMessageAutoSubscriberViewController.h"

@interface RWPushMessageAutoSubscriberViewController ()

@end

@implementation RWPushMessageAutoSubscriberViewController

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWPushMessageAutoSubscriberViewController" bundle:nil page:page];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

	[_app.pmh subscribeToPushMessages];
	NSLog(@"Subscribing to push messages");
	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	RWXmlNode *nextPage = [_xml getPage:_childname];
    [_app.navController pushViewWithPage:nextPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
