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
	
	RWNode *_childPage;
}

-(id)initWithStartPage:(RWNode *)startPage
{
    self = [super initWithNibName:@"RWMainViewController" bundle:nil];
    if (self) {
//        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
		
		_childPage = startPage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
	RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
	_xml = [app xml];
	
	[app.navController connectToMainView:self];

	[app.navController pushViewWithParameters:[_childPage getDictionaryFromNode]];
	
//	UIViewController *startView = [RWNavigationController getViewControllerFromDictionary:[_childPage getDictionaryFromNode]];
//	[self addMainView:startView];
	
	
	[self setBarVisibility];
	[self setAppearance];
}

- (void)setBarVisibility{
	RWNode *appearance = _xml.appearance;
	if ([appearance hasChild:[RWLOOK TABBAR]]) {
		RWNode *tabbarNode = [appearance getChildFromNode:[RWLOOK TABBAR]];
		if ([tabbarNode hasChild:[RWLOOK TABBAR_VISIBLE]] && ![tabbarNode getBoolFromNode:[RWLOOK TABBAR_VISIBLE]]) {
			[_tabbar RWsetHeightAsConstraint:0.0];
		}
	}
	if ([appearance hasChild:[RWLOOK NAVIGATIONBAR]]) {
		RWNode *navbarNode = [appearance getChildFromNode:[RWLOOK NAVIGATIONBAR]];
		if ([navbarNode hasChild:[RWLOOK NAVBAR_VISIBLE]] && ![navbarNode getBoolFromNode:[RWLOOK NAVBAR_VISIBLE]]) {
			[_navbar RWsetHeightAsConstraint:0.0];
		}
	}

}

- (void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:nil globalLook:[_xml getAppearanceForPage:[RWLOOK GLOBAL]]];
	
	if([_xml.pages hasChild:@"global"] && [[_xml.pages getChildFromNode:@"global"] hasChild:@"toplogo"]){
		NSString *toplogoimagename = [[_xml.pages getChildFromNode:@"global"] getStringFromNode:@"toplogo"];
		[helper setLogo:_logobar imagename:toplogoimagename];
	} else {
		[_logobar RWsetHeightAsConstraint:0.0];
	}
}

- (void)replaceMainViewWith:(UIViewController *)newViewController{
	
	[_childView.view removeFromSuperview];
	[self addMainView:newViewController];
}

- (void)addMainView:(UIViewController *)newViewController{
	_childView = newViewController;
	
	[_mainView addSubview:_childView.view];
	[self addChildViewController:_childView];
	
	[_mainView RWpinChildToTop:_childView.view];
	[_mainView RWpinChildToSides:_childView.view];
	[_mainView RWpinChildToBottom:_childView.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
