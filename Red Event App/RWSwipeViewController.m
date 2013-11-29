//
//  RWSwipeViewController.m
//  Jule App
//
//  Created by Thorbjørn Steen on 11/4/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIColor+RWColor.h"

#import "RWSwipeViewController.h"
#import "RWAppDelegate.h"
#import "RWDbInterface.h"
#import "RWXMLStore.h"
#import "RWNavigationController.h"

@interface RWSwipeViewController ()

@end

@implementation RWSwipeViewController {
	NSMutableArray *_datasource;
}


- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWSwipeViewController" bundle:nil page:page];
    if (self) {
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
	
	NSArray *leafNames = [_page getAllChildValuesWithName:[RWPAGE SECTION]];
	_datasource = [[NSMutableArray alloc] init];
	
	for (NSString *leafname in leafNames) {
		RWXmlNode *leafpage = [_xml getPage:leafname];
		UIViewController *viewController = [RWNavigationController getViewControllerFromPage:leafpage];
		[_datasource addObject:viewController];
	}
	
	NSArray *viewControllers = [NSArray arrayWithObject:_datasource[0]];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
	
	UIView *pageView = self.pageViewController.view;
	NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(pageView);
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[pageView]|" options:0 metrics:nil views:viewDictionary]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[pageView]|" options:0 metrics:nil views:viewDictionary]];
	
	pageView.frame = self.view.frame;
	
	[self setAppearance];
}

-(void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:_pageViewController.view localImageName:[RWLOOK SWIPEVIEW_BACKGROUNDIMAGE] localColorName:[RWLOOK SWIPEVIEW_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	UIPageControl *pageControl = [UIPageControl appearance];
	if ([_localLook hasChild:[RWLOOK SWIPEVIEW_SELECTEDPAGECOLOR]]) {
		pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:[_localLook getStringFromNode:[RWLOOK SWIPEVIEW_SELECTEDPAGECOLOR]]];
	}
	
	if ([_localLook hasChild:[RWLOOK SWIPEVIEW_UNSELECTEDPAGECOLOR]]) {
		pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:[_localLook getStringFromNode:[RWLOOK SWIPEVIEW_UNSELECTEDPAGECOLOR]]];
	}
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	return [self getPreviousLeaf:viewController];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	return [self getNextLeaf:viewController];
}

-(UIViewController *)getNextLeaf:(UIViewController *)currentLeafController{
	RWBaseViewController *currentController = ((RWBaseViewController *)currentLeafController);
	uint currentIndex = [self findIndexOf:currentController];
	uint nextLeaf = currentIndex;
	if(nextLeaf == _datasource.count-1){
		nextLeaf = 0;
    } else {
		nextLeaf += 1;
	}
	return _datasource[nextLeaf];
}

-(UIViewController *)getPreviousLeaf:(UIViewController *)currentLeafController{
	uint currentIndex = [self findIndexOf:((RWBaseViewController *)currentLeafController)];
	uint prevLeaf = currentIndex;
	if(prevLeaf == 0){
		prevLeaf = _datasource.count-1;
    } else {
		prevLeaf -= 1;
	}
	return _datasource[prevLeaf];
}

-(int)findIndexOf:(RWBaseViewController *)vc{
	int i = 0;
	for (RWBaseViewController *arrayVc in _datasource) {
		if([arrayVc isEqual:vc])
		{
			return i;
		}
		i++;
	}
	return NSNotFound;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return _datasource.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
