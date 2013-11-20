//
//  RWNewsTickerView2.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/4/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWNewsTickerView2.h"
#import "RWNewstickerItem.h"

#import "RWArticleDetailViewController.h"

#import "RWPAGE.h"
#import "RWXmlNode.h"
#import "RWDbArticles.h"
#import "RWAppDelegate.h"
#import "RWTEXT.h"
#import "RWDEFAULTTEXT.h"
#import "RWTextHelper.h"
#import "RWAppearanceHelper.h"
#import "RWLOOK.h"

@interface RWNewsTickerView2 ()

@end

@implementation RWNewsTickerView2 {
    RWAppDelegate *_app;
    RWDbInterface *_db;
    RWXMLStore *_xml;

	NSString *_name;
    RWXmlNode *_page;

    NSMutableArray *_itemViewControllers;
	NSUInteger currentIndex;
	
	NSArray *_datasource;
}

- (id)initWithPage:(RWXmlNode *)componentpage
{
    self = [super initWithNibName:@"RWNewsTickerView2" bundle:nil];
    if (self) {
        _page = componentpage;
		_name = [_page getStringFromNode:[RWPAGE NAME]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _itemViewControllers = [[NSMutableArray alloc] init];
    _app = [[UIApplication sharedApplication] delegate];
    _db = _app.db;
    _xml = _app.xml;
	
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;

    int catid = [_page getIntegerFromNode:[RWPAGE CATID]];
    _datasource = [_db.Articles getVMListFromCatId:catid];
    [self addArticleItems];
	
    NSArray *viewControllers = [NSArray arrayWithObject:_itemViewControllers[currentIndex]];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
	
	[self setGestureRecognizers];
	[self setConstraints];
	
	[self setAppearance];
	[self setText];
}

- (void)addArticleItems {
    for (int i = 0; i < 3; i++) {
        RWArticleVM *model = _datasource[i];
        RWNewstickerItem *newsItem = [[RWNewstickerItem alloc] initWithModel:model page:_page];
		newsItem.leafNumber = i;

        [_itemViewControllers addObject:newsItem];
		newsItem.view.frame = CGRectMake(0, 25, 320, 150);
    }
}

- (void)setGestureRecognizers{
	self.view.gestureRecognizers = _pageViewController.gestureRecognizers;
	
	UITapGestureRecognizer *myTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(componentTapped)];
	[self.view addGestureRecognizer:myTapRecognizer];
}

-(void)componentTapped{
	NSString *childname = [_page getStringFromNode:[RWPAGE CHILD]];
	RWNewstickerItem *item = _itemViewControllers[currentIndex];
	
	RWXmlNode *childPage = [_xml getPage:childname];
	NSMutableDictionary *childDictionary = [[NSMutableDictionary alloc]initWithDictionary:[childPage getDictionaryFromNode]];
	[childDictionary setObject:item.model.articleid forKey:[RWPAGE ARTICLEID]];
}

-(void)setConstraints{
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_pageViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	//title constraints
	//[_lblTitle RWsetHeightAsConstraint:_lblTitle.frame.size.height];
	[self.view RWpinChildToTop:_lblTitle];
    [self.view RWpinChildToSides:_lblTitle];
    [self.view RWpinChildrenTogetherWithTopChild:_lblTitle BottomChild:_pageViewController.view];
    //pageViewController constraints
	[self.view RWpinChildToLeading:_pageViewController.view];
	
	
}

-(void)setAppearance{
	RWXmlNode *globalLook = [_xml getAppearanceForPage:[RWLOOK DEFAULT]];
	RWXmlNode *localLook = [_xml getAppearanceForPage:_name];
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];
	
	[helper setBackgroundColor:[self view] localName:[RWLOOK NEWSTICKER_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper setLabelColor:_lblTitle localName:[RWLOOK NEWSTICKER_TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblTitle localSizeName:[RWLOOK NEWSTICKER_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE] localStyleName:[RWLOOK NEWSTICKER_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
	[helper setLabelShadowColor:_lblTitle localName:[RWLOOK NEWSTICKER_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblTitle localName:[RWLOOK NEWSTICKER_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];
}

-(void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblTitle textName:[RWTEXT NEWSTICKER_TITLE] defaultText:[RWDEFAULTTEXT NEWSTICKER_TITLE]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	return [self getPreviousLeaf:viewController];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	return [self getNextLeaf:viewController];
}

-(UIViewController *)getNextLeaf:(UIViewController *)currentLeafController{
	currentIndex = ((RWNewstickerItem *)currentLeafController).leafNumber;
    if(currentIndex == _itemViewControllers.count-1){
		currentIndex = 0;
    } else {
		currentIndex += 1;
	}
    return _itemViewControllers[currentIndex];
}

-(UIViewController *)getPreviousLeaf:(UIViewController *)currentLeafController{
	currentIndex = ((RWNewstickerItem *)currentLeafController).leafNumber;
    if(currentIndex == 0){
        currentIndex = _itemViewControllers.count-1;
    } else {
		currentIndex -= 1;
	}
    return _itemViewControllers[currentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
