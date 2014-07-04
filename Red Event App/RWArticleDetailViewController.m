//
//  RWContentDetailViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/21/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIView+RWViewLayout.h"
#import "UIWebView+RWWebView.h"

#import "RWArticleDetailViewController.h"

#import "RWArticleVM.h"
#import "RWAppearanceHelper.h"

@interface RWArticleDetailViewController ()

@end

@implementation RWArticleDetailViewController {

    RWArticleVM *_model;
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWArticleDetailViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
		
    [self setAppearance];
	[self setText];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_vwContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];

    int articleId = [_page getIntegerFromNode:[RWPAGE ARTICLEID]];
	_model = [_db.Articles getVMFromId:articleId];

    _lblTitle.text = _model.title;

    if([_page hasChild:[RWPAGE BODYUSESHTML]] && [_page getBoolFromNode:[RWPAGE BODYUSESHTML]])
    {
		[_scrollView setHidden:YES];
		NSString *title = [NSString stringWithFormat:@"<div class=“page-header”><h1>%@</h1></div>",_model.title];
		NSString *webString = [NSString stringWithFormat:@"%@%@%@", _xml.css, title, _model.fulltextWithHtml];
        [_webBody loadHTMLString:webString  baseURL:[NSURL URLWithString:_xml.imagesRootPath]];
    } else {
        [_webBody setHidden:YES];
        _lblBody.text = _model.fulltextWithoutHtml;
		if (_model.mainImagePath && ![_model.mainImagePath isEqual:@""]) {
			[_imgView setImageWithURL:_model.mainImageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]
							completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
								float imageHeight = image.size.height;
                                float aspectHeight = imageHeight * _imgView.frame.size.width / image.size.width;
                                [_imgView RWsetHeightAsConstraint:aspectHeight];
                            }];
		}
		else if (![_model.introImagePath isEqual:@""]) {
			_imgView.image = _model.image;
		}
    }
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:_imgBackground localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.label setTitleStyle:_lblTitle];
    [helper.label setBackTextStyle:_lblBody];

	[helper setScrollBounces:_scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

-(void)setText{
	
}

- (void)getReturnImage:(UIImage *)image {
    _model.image = image;
    _imgView.image = image;
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [webView RWSizeThatFitsContent];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	if(navigationType == UIWebViewNavigationTypeLinkClicked){
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}

-(IBAction)btnBackClicked{
    [_app.navController popPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
