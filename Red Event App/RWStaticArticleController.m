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

	NSString *title = @"<div class=“page-header”><h1><a href=“/om-festivalen/om-festivalen”>Om festivalen</a></h1></div>";
	NSString *webtext = [NSString stringWithFormat:@"%@%@%@", _xml.css, title, _model.introtextWithHtml];
	[_webBody loadHTMLString:webtext baseURL:[NSURL URLWithString:_xml.imagesRootPath]];

	[self setAppearance];
	
	if(![_page hasChild:[RWPAGE RETURNBUTTON]] || ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
		[_btnBack RWsetHeightAsConstraint:0.0];
		[_btnBack setHidden:YES];
	} else if([_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]]){
		UIImage *btnImage = _btnBack.currentBackgroundImage;
		float aspect = btnImage.size.height/btnImage.size.width;
		[_btnBack addConstraint:[NSLayoutConstraint constraintWithItem:_btnBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_btnBack attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
	}
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper.button setBackButtonStyle:_btnBack];
	
	[helper setScrollBounces:_webBody.scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	if(navigationType == UIWebViewNavigationTypeLinkClicked){
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
