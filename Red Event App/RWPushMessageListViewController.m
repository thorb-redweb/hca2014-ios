//
//  RWPushMessageListViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWPushMessageListViewController.h"

@interface RWPushMessageListViewController ()

@end

@implementation RWPushMessageListViewController{
    NSArray *_dataSource;
}

- (id)initWithName:(NSString *)name
{
    self = [super initWithNibName:nil bundle:nil name:name];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //TODO: Hacks!!!! Tableview doesn't call numberOfRowsInSection if TranslatesAutoresizingMaskIntoConstraints is set to NO, and the page is in a swipeview. The below if construct "solves" that problem.
    if(![_xml swipeViewHasPage:_page]){
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }

//    if([_page hasChild:[RWPAGE PUSHGROUPIDS]] && [_page hasChild:[RWPAGE SUBSCRIPTIONS]] && [_page getBoolFromNode:[RWPAGE SUBSCRIPTIONS]])
//    {
//        _dataSource = _db.PushMessages.getVMListFromGroupIds(_page.getIntegerArrayFromNode(PAGE.PUSHGROUPIDS));
//    } else if(_page.hasChild(PAGE.PUSHGROUPIDS))
//    {
//        _dataSource = _db.PushMessages.getVMListFromGroupIds(_page.getIntegerArrayFromNode(PAGE.PUSHGROUPIDS));
//    } else {
//        _dataSource = _db.PushMessages.getVMListFromSubscribedGroups();
//    }
//
//    [self setAppearance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
