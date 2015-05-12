//
//  RWNavigationController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/20/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWNavigationController.h"
#import "RWAppDelegate.h"

#import "RWArticleDetailViewController.h"
#import "RWButtonGalleryViewController.h"
#import "RWDailySessionListViewController.h"
#import "RWImageArticleListViewController.h"
#import "RWMainViewController.h"
#import "RWOverviewMapViewController.h"
#import "RWPushMessageDetailViewController.h"
#import "RWPushMessageListViewController.h"
#import "RWSessionDetailViewController.h"
#import "RWSessionMapViewController.h"
#import "RWStaticArticleController.h"
#import "RWSwipeViewController.h"
#import "RWTableNavigatorViewController.h"
#import "RWVenueDetailViewController.h"
#import "RWVenueMapViewController.h"
#import "RWPushMessageAutoSubscriberViewController.h"
#import "RWWebViewController.h"
#import "RWCameraIntentViewController.h"
#import "RWImageUploaderViewController.h"
#import "RWImageUploadBrowserViewController.h"
#import "RWHcaSplitView.h"

@interface RWNavigationController ()

@end

@implementation RWNavigationController{
	RWNavController *_navbar;
	RWMainViewController *_mainViewController;
	UIView *_mainView;
	NSMutableArray *viewControllers;
	
	RWSwipeViewController *_swipeview;
}

-(void)resetRootViewSize{
	_mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	_mainView = _mainViewController.mainView;
}

- (void)connectToMainView:(RWMainViewController *)mainViewcontroller{
	viewControllers = [[NSMutableArray alloc] init];
	_mainViewController = mainViewcontroller;
	_mainView = mainViewcontroller.mainView;
	_navbar = mainViewcontroller.navbar;
}

- (void)pushViewWithPage:(RWXmlNode *)page {
    [self pushViewWithPage:page addToBackStack:YES];
}

- (void)pushViewWithPage:(RWXmlNode *)page addToBackStack:(bool)addToBackStack{
	if([page hasChild:[RWPAGE NAME]]){
        NSLog(@"Pushing view with page: %@",[page getStringFromNode:[RWPAGE NAME]]);
	}
	RWAppDelegate *app = (RWAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *type =  [page getStringFromNode:[RWPAGE TYPE]];
    NSString *parent = nil;
    BOOL pageBelongsToSwipeView = false;
    if([page hasChild:[RWPAGE PARENT]]){
        parent = [page getStringFromNode:[RWPAGE PARENT]];
        pageBelongsToSwipeView = [app.xml nameBelongsToSwipeView:parent];
    }
	
	if(pageBelongsToSwipeView){
		RWXmlNode *swipeViewPage = [app.xml getPage:parent];
		RWSwipeViewController *swipeViewController = (RWSwipeViewController *)[RWNavigationController getViewControllerFromPage:swipeViewPage];
		_swipeview = swipeViewController;
		[self pushViewController:swipeViewController addToBackStack:addToBackStack ];
	}
    else if([type isEqual:[RWTYPE SWIPEVIEW]]){
        RWSwipeViewController *swipeViewController = (RWSwipeViewController *)[RWNavigationController getViewControllerFromPage:page];
		_swipeview = swipeViewController;
		[self pushViewController:swipeViewController addToBackStack:YES];
    }
	else if([type isEqual:[RWTYPE PUSHMESSAGEAUTOSUBSCRIBER]]){
        UIViewController *newViewController = [RWNavigationController getViewControllerFromPage:page];
        [self pushViewController:newViewController addToBackStack:NO];
    }
	else{
		UIViewController *newViewController = [RWNavigationController getViewControllerFromPage:page];
		[self pushViewController:newViewController addToBackStack:addToBackStack ];
	}
}

- (void)pushViewController:(RWBaseViewController *)newViewController addToBackStack:(bool)addToBackStack {

	RWBaseViewController *currentViewController = viewControllers.lastObject;
	if(addToBackStack){
	    [viewControllers addObject:newViewController];
    }
	
	[UIView transitionWithView:_mainView duration:0.5
					   options:UIViewAnimationOptionTransitionFlipFromRight
					animations:^ {
						[_mainView addSubview:newViewController.view];
						[_mainView RWpinChildToTop:newViewController.view];
						[_mainView RWpinChildToSides:newViewController.view];
						[_mainView RWpinChildToBottom:newViewController.view];
					}
					completion:nil];
	
	[_mainViewController addChildViewController:newViewController];
	
	[currentViewController.view removeFromSuperview];
	[currentViewController removeFromParentViewController];
	if([newViewController isKindOfClass:[RWBaseViewController class]] && newViewController.controllerPage){
		[_navbar handleNewPage:newViewController.controllerPage];
	}
}

- (void)popPage {
	[self popPageNumberTimes:1];
}

- (void)popTwoPages {
	[self popPageNumberTimes:2];
}

- (void)popPageNumberTimes:(int)popTimes {
	RWBaseViewController *previousViewController = viewControllers[viewControllers.count-(popTimes+1)];
	NSMutableArray *viewControllersToDrop = [[NSMutableArray alloc] init];
	for (int i = viewControllers.count - 1; i >= viewControllers.count - popTimes; i--) {
		[viewControllersToDrop addObject:viewControllers[i]];
	}
		
	[UIView transitionWithView:_mainView duration:0.5
					   options: UIViewAnimationOptionTransitionFlipFromLeft
					animations:^ {
						[_mainView addSubview:previousViewController.view];
						[_mainView RWpinChildToTop:previousViewController.view];
						[_mainView RWpinChildToSides:previousViewController.view];
						[_mainView RWpinChildToBottom:previousViewController.view];
					}
					completion:nil];
	
	[_mainViewController addChildViewController:previousViewController];
	
	[((UIViewController *)viewControllersToDrop[0]).view removeFromSuperview];
	[viewControllersToDrop[0] removeFromParentViewController];
	
	for (UIViewController *viewController in viewControllersToDrop) {
		[viewControllers removeObject:viewController];
	}
	if([previousViewController isKindOfClass:[RWBaseViewController class]] && previousViewController.controllerPage){
		[_navbar handleNewPage:previousViewController.controllerPage];
	}
}

- (bool)hasPreviousPage{
	if(viewControllers.count > 1){
		return true;
	}
	return false;
}

- (RWSwipeViewController *)getSwipeView{
	return _swipeview;
}

+ (UIViewController *)getViewControllerFromPage:(RWXmlNode *)page {
    NSString *viewControllerType = [page getStringFromNode:[RWPAGE TYPE]];

    NSLog(@"View controller pagetype: %@", viewControllerType);

	if ([viewControllerType isEqual:[RWTYPE ARTICLEDETAIL]]) {
        return [[RWArticleDetailViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE BUTTONGALLERY]]) {
        return [[RWButtonGalleryViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE CAMERAINTENT]]) {
        return [[RWCameraIntentViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE DAILYSESSIONLIST]]) {
        return [[RWDailySessionListViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE FILEBROWSER]]) {
        return [[RWImageUploadBrowserViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE HCASPLITVIEW]]) {
        return [[RWHcaSplitView alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE IMAGEARTICLELIST]]) {
        return [[RWImageArticleListViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE IMAGEUPLOADER]]) {
        return [[RWImageUploaderViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE PUSHMESSAGEAUTOSUBSCRIBER]]) {
        return [[RWPushMessageAutoSubscriberViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE PUSHMESSAGEDETAIL]]) {
        return [[RWPushMessageDetailViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE PUSHMESSAGELIST]]) {
        return [[RWPushMessageListViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE OVERVIEWMAP]]) {
        return [[RWOverviewMapViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE SESSIONDETAIL]]) {
        return [[RWSessionDetailViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE SESSIONMAP]]) {
        return [[RWSessionMapViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE STATICARTICLE]]) {
        return [[RWStaticArticleController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE SWIPEVIEW]]) {
        return [[RWSwipeViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE TABLENAVIGATOR]]) {
        return [[RWTableNavigatorViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE VENUEDETAIL]]) {
        return [[RWVenueDetailViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE VENUEMAP]]) {
        return [[RWVenueMapViewController alloc] initWithPage:page];
    }
    else if ([viewControllerType isEqual:[RWTYPE WEBVIEW]]) {
        return [[RWWebViewController alloc] initWithPage:page];
    }
    return nil;
}

@end
