//
//  RWMainViewController.m
//  Jule App
//
//  Created by Thorbjørn Steen on 11/6/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWMainViewController.h"

#import "RWAppDelegate.h"
#import "RWNavigationController.h"
#import "RWXMLStore.h"

#import "RWAppearanceHelper.h"

@interface RWMainViewController ()

@end

@implementation RWMainViewController{
	RWXMLStore *_xml;
	
	RWXmlNode *_childPage;

    bool _firstTime;
}

-(id)initWithStartPage:(RWXmlNode *)startPage
{
    self = [super initWithNibName:@"RWMainViewController" bundle:nil];
    if (self) {
		_childPage = startPage;
        _firstTime = true;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    if(_firstTime){
        RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
        _xml = [app xml];

        [app.navController connectToMainView:self];

        [app.navController pushViewWithPage:_childPage];

        [self setBarVisibility];
        [self setAppearance];
        _firstTime = false;
    }
}

- (void)setBarVisibility{
	RWXmlNode *appearance = _xml.appearance;
	if ([appearance hasChild:[RWLOOK TABBAR]]) {
		RWXmlNode *tabbarNode = [appearance getChildFromNode:[RWLOOK TABBAR]];
		if ([tabbarNode hasChild:[RWLOOK TABBAR_VISIBLE]] && ![tabbarNode getBoolFromNode:[RWLOOK TABBAR_VISIBLE]]) {
			[_tabbar RWsetHeightAsConstraint:0.0];
		}
	}
	if ([appearance hasChild:[RWLOOK NAVIGATIONBAR]]) {
		RWXmlNode *navbarNode = [appearance getChildFromNode:[RWLOOK NAVIGATIONBAR]];
		if ([navbarNode hasChild:[RWLOOK NAVBAR_VISIBLE]] && ![navbarNode getBoolFromNode:[RWLOOK NAVBAR_VISIBLE]]) {
			[_navbar RWsetHeightAsConstraint:0.0];
		}
	}

}

- (void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:nil globalLook:[_xml getAppearanceForPage:[RWLOOK DEFAULT]]];
	
	if([_xml.pages hasChild:@"global"] && [[_xml.pages getChildFromNode:@"global"] hasChild:@"toplogo"]){
		NSString *toplogoimagename = [[_xml.pages getChildFromNode:@"global"] getStringFromNode:@"toplogo"];
		[_logobar RWsetHeightAsConstraint:50.0];
		[helper setLogo:_logobar imagename:toplogoimagename];
	} else {
		[_logobar RWsetHeightAsConstraint:0.0];
	}
}

- (void)tabBar:(RWTabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	RWXmlNode *tabPage = tabBar.tabpages[item.tag];
    RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.navController pushViewWithPage:tabPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
