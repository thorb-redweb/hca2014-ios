//
//  RWStaticArticleController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWStaticArticleController.h"
#import "RWArticleVM.h"
#import "RWAppearanceHelper.h"
#import "RWSwipeViewController.h"

@interface RWStaticArticleController ()

@end

@implementation RWStaticArticleController {
    RWArticleVM *_model;
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWStaticArticleController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![_xml swipeViewHasPage:_page]){
		[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}

	
    int articleId = [_page getIntegerFromNode:[RWPAGE ARTICLEID]];
    _model = [_db.Articles getVMFromId:articleId];

    [_webBody loadHTMLString:_model.fulltext baseURL:nil];
	[self.view setBackgroundColor:[UIColor redColor]];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK STATICARTICLE_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
}

//-(void)updateViewConstraints{
//	if(![_xml swipeViewHasPage:_page]){
//		RWSwipeViewController *swipeViewController = [_app.navController getSwipeView];
//		UIView *swipeView = swipeViewController.pageViewController.view;
//		[swipeView RWpinChildToTop:self.view];
//		[swipeView RWpinChildToSides:self.view];
//		[swipeView RWpinChildToBottom:self.view];
//	}
//	
//	[super updateViewConstraints];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
