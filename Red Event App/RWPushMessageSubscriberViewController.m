//
//  RWPushMessageSubscriberViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/26/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWPushMessageSubscriberViewController.h"
#import "RWXmlNode.h"

@interface RWPushMessageSubscriberViewController ()

@end

@implementation RWPushMessageSubscriberViewController

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWPushMessageSubscriberViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
