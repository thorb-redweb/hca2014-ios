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

	[self setAppearance];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK STATICARTICLE_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper setScrollBounces:_webBody.scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
