//
//  RWFrontPageViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWSplitViewController.h"

#import "RWUpcomingSessions.h"
#import "RWNewstickerView2.h"


@interface RWSplitViewController ()

@end

@implementation RWSplitViewController {
	UIViewController *topView;
	UIViewController *bottomView;
}

- (id)initWithName:(NSString *)name{
    self = [super initWithNibName:@"RWSplitViewController" bundle:nil name:name];
    if (self) {
        self.title = @"RedEvent";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubview];
}

- (void)setupSubview {
    RWNode *topElement = [_page getChildFromNode:[RWPAGE TOP]];
    RWNode *bottomElement = [_page getChildFromNode:[RWPAGE BOTTOM]];

    topView = [self getSubviewWithPage:topElement];
	[self addChildViewController:topView];
    [self.view addSubview:topView.view];

    bottomView = [self getSubviewWithPage:bottomElement];
	[self addChildViewController:bottomView];
    [self.view addSubview:bottomView.view];
	
	[topView.view removeConstraints:topView.view.constraints];
	
    //topview constraints
    [self.view RWsetChildHeightAsConstraintWithMultiplier:1.0f view1:topView.view view2:bottomView.view];
	[self.view RWpinChildToTop:topView.view];
    [self.view RWpinChildToSides:topView.view];
    [self.view RWpinChildrenTogetherWithTopChild:topView.view BottomChild:bottomView.view];
    //bottomview constraints
    [self.view RWpinChildToSides:bottomView.view];
}

- (UIViewController *)getSubviewWithPage:(RWNode *)elementPage {
    NSString *type = [elementPage getStringFromNode:[RWPAGE COMPONENTTYPE]];
    if ([type isEqual:[RWTYPE UPCOMINGSESSIONS]]) {
		CGRect tableFrame = CGRectMake(0, 25, 320, 150);
        return [[RWUpcomingSessions alloc] initWithFrame:tableFrame subviewElement:elementPage];
   } else if ([type isEqual:[RWTYPE NEWSTICKER]]) {
        return [[RWNewsTickerView2 alloc] initWithPage:elementPage];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
