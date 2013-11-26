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

#import "RWAdventCalViewController.h"
#import "RWAdventWindowViewController.h"
#import "RWArticleListViewController.h"
#import "RWArticleDetailViewController.h"
#import "RWButtonGalleryViewController.h"
#import "RWDailySessionListViewController.h"
#import "RWImageArticleListViewController.h"
#import "RWMainViewController.h"
#import "RWOverviewMapViewController.h"
#import "RWPushMessageDetailViewController.h"
#import "RWPushMessageListViewController.h"
#import "RWSessionDetailViewController.h"
#import "RWSessionListViewController.h"
#import "RWSessionMapViewController.h"
#import "RWStaticArticleController.h"
#import "RWSplitViewController.h"
#import "RWSwipeViewController.h"
#import "RWTableNavigatorViewController.h"
#import "RWVenueDetailViewController.h"
#import "RWVenueMapViewController.h"

@interface RWNavigationController ()

@end

@implementation RWNavigationController{
	UINavigationBar *_navbar;
	RWMainViewController *_mainViewController;
	UIView *_mainView;
	NSMutableArray *viewControllers;
}

- (void)connectToMainView:(RWMainViewController *)mainViewcontroller{
	viewControllers = [[NSMutableArray alloc] init];
	_mainViewController = mainViewcontroller;
	_mainView = mainViewcontroller.mainView;
	_navbar = mainViewcontroller.navbar;
}

- (void)pushViewFromTab:(RWXmlNode *)tabPage {
    NSDictionary *parameters = [tabPage getDictionaryFromNode];

    [self pushViewWithParameters:parameters];
}

- (void)pushViewWithParameters:(NSDictionary *)parameters {
	RWAppDelegate *app = (RWAppDelegate *)[[UIApplication sharedApplication] delegate];
	BOOL pageBelongsToSwipeView = [parameters objectForKey:[RWPAGE PARENT]] != nil && [app.xml nameBelongsToSwipeView:[parameters objectForKey:[RWPAGE PARENT]]];
	if (!pageBelongsToSwipeView){
		UIViewController *newViewController = [RWNavigationController getViewControllerFromDictionary:parameters];
		[self pushViewController:newViewController];
	}
	else {
		RWXmlNode *swipeView = [app.xml getPage:[parameters objectForKey:[RWPAGE PARENT]]];
		UIViewController *swipeViewController = [RWNavigationController getViewControllerFromDictionary:[swipeView getDictionaryFromNode]];
		[self pushViewController:swipeViewController];
	}
}

- (void)pushViewController:(UIViewController *)newViewController {

	UIViewController *currentViewController = viewControllers.lastObject;
	
	[viewControllers addObject:newViewController];
	
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
}


- (void)popViewController{
	UIViewController *previousViewController = viewControllers[viewControllers.count-2];
	UIViewController *currentViewController = viewControllers.lastObject;
		
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
	
	[currentViewController.view removeFromSuperview];
	[currentViewController removeFromParentViewController];
	
	[viewControllers removeObject:currentViewController];
}

+ (UIViewController *)getViewControllerFromDictionary:(NSDictionary *)parameters {
    NSString *name = parameters[[RWPAGE NAME]];
    NSString *viewControllerType = parameters[[RWPAGE TYPE]];
	if ([viewControllerType isEqual:[RWTYPE ADVENTCAL]]) {
        return [[RWAdventCalViewController alloc] initWithName:name];
    }
    else if ([viewControllerType isEqual:[RWTYPE ADVENTWINDOW]]) {
		int articleid = [parameters[[RWPAGE ARTICLEID]] intValue];
        return [[RWAdventWindowViewController alloc] initWithName:name articleid:articleid];
    }
    else if ([viewControllerType isEqual:[RWTYPE ARTICLELIST]]) {
        int catid = [parameters[[RWPAGE CATID]] intValue];
        return [[RWArticleListViewController alloc] initWithNibName:@"RWArticleListViewController" bundle:nil name:name catid:catid];
    }
    else if ([viewControllerType isEqual:[RWTYPE ARTICLEDETAIL]]) {
        int articleid = [parameters[[RWPAGE ARTICLEID]] intValue];
        return [[RWArticleDetailViewController alloc] initWithNibName:@"RWArticleDetailViewController" bundle:nil name:name articleid:articleid];
    }
    else if ([viewControllerType isEqual:[RWTYPE BUTTONGALLERY]]) {
        return [[RWButtonGalleryViewController alloc] initWithName:name];
    }
    else if ([viewControllerType isEqual:[RWTYPE DAILYSESSIONLIST]]) {
        return [[RWDailySessionListViewController alloc] initWithNibName:@"RWDailySessionListViewController" bundle:nil name:name];    }
    else if ([viewControllerType isEqual:[RWTYPE IMAGEARTICLELIST]]) {
        int catid = [parameters[[RWPAGE CATID]] intValue];
        return [[RWImageArticleListViewController alloc] initWithNibName:@"RWImageArticleListViewController" bundle:nil name:name catid:catid];
    }
    else if ([viewControllerType isEqual:[RWTYPE PUSHMESSAGEDETAIL]]) {
		int pushmessageid = [parameters[[RWPAGE PUSHMESSAGEID]] intValue];
        return [[RWPushMessageDetailViewController alloc] initWithName:name pushmessageid:pushmessageid];
    }
    else if ([viewControllerType isEqual:[RWTYPE PUSHMESSAGELIST]]) {
        return [[RWPushMessageListViewController alloc] initWithName:name];
    }
    else if ([viewControllerType isEqual:[RWTYPE OVERVIEWMAP]]) {
        return [[RWOverviewMapViewController alloc] initWithName:name];
    }
    else if ([viewControllerType isEqual:[RWTYPE SESSIONDETAIL]]) {
        int sessionid = [parameters[[RWPAGE SESSIONID]] intValue];
        return [[RWSessionDetailViewController alloc] initWithNibName:@"RWSessionDetailViewController" bundle:nil sessionid:sessionid name:name];
    }
    else if ([viewControllerType isEqual:[RWTYPE SESSIONMAP]]) {
        int sessionid = [parameters[[RWPAGE SESSIONID]] intValue];
        return [[RWSessionMapViewController alloc] initWithName:name sessionid:sessionid];
    }
    else if ([viewControllerType isEqual:[RWTYPE SPLITVIEW]]) {
        return [[RWSplitViewController alloc] initWithName:name];

    }
    else if ([viewControllerType isEqual:[RWTYPE STATICARTICLE]]) {
        int articleid = [parameters[[RWPAGE ARTICLEID]] intValue];
        return [[RWStaticArticleController alloc] initWithNibName:@"RWStaticArticleController" bundle:nil name:name articleid:articleid];
    }
    else if ([viewControllerType isEqual:[RWTYPE SWIPEVIEW]]) {
        return [[RWSwipeViewController alloc] initWithName:name];
		
    }
    else if ([viewControllerType isEqual:[RWTYPE TABLENAVIGATOR]]) {
        return [[RWTableNavigatorViewController alloc] initWithName:name];
		
    }
    else if ([viewControllerType isEqual:[RWTYPE VENUEDETAIL]]) {
        int venueid = [parameters[[RWPAGE VENUEID]] intValue];
        return [[RWVenueDetailViewController alloc] initWithName:name venueId:venueid];
    }
    else if ([viewControllerType isEqual:[RWTYPE VENUEMAP]]) {
        int venueid = [parameters[[RWPAGE VENUEID]] intValue];
        return [[RWVenueMapViewController alloc] initWithName:name venueid:venueid];
    }
    return nil;
}

@end
