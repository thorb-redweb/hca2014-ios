//
//  RWAdventWindowViewController.m
//  Jule App
//
//  Created by Thorbjørn Steen on 10/29/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIScrollView+RWScrollView.h"
#import "UIWebView+RWWebView.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIView+RWViewLayout.h"

#import "RWAdventWindowViewController.h"
#import "RWArticleVM.h"

@interface RWAdventWindowViewController ()

@end

@implementation RWAdventWindowViewController{
    RWArticleVM *_article;
}

- (id)initWithPage:(RWXmlNode *)page{
	self = [super initWithNibName:@"RWAdventWindowViewController" bundle:nil page:page];
    if (self) {

	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_scrollview setTranslatesAutoresizingMaskIntoConstraints:NO];
	
    int articleId = [_page getIntegerFromNode:[RWPAGE ARTICLEID]];
	_article = [_db.Articles getVMFromId:articleId];
	
	[self setAppearance];
	[self setText];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_vwContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
	
	NSDateFormatter *dateFormatFromArticle = [[NSDateFormatter alloc] init];
	[dateFormatFromArticle setDateFormat:@"yyyy-MM-dd"];
	NSDate *windowDate = [dateFormatFromArticle dateFromString:_article.title];
	
	NSDateFormatter *dateFormatToTitle = [[NSDateFormatter alloc] init];
	[dateFormatToTitle setDateFormat:@"dd MMMM"];
	NSString *title = [dateFormatToTitle stringFromDate:windowDate];
	
	[_lblTitle setText:title];
	
	[_imgPicture setImageWithURL:_article.mainImageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
	 {
		 float aspect = image.size.height/image.size.width;
		 [_imgPicture addConstraint:[NSLayoutConstraint constraintWithItem:_imgPicture attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imgPicture attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
	 }];
	
	CGRect bounds;
	bounds.origin = CGPointZero;
	bounds.size = _imgPicture.image.size;
	
	_imgPicture.bounds = bounds;
	
	if([_page hasChild:[RWPAGE BODYUSESHTML]] && [_page getBoolFromNode:[RWPAGE BODYUSESHTML]])
    {
        [_lblBody setHidden:YES];
		[_webBody loadHTMLString:_article.introtextWithHtml baseURL:nil];
		[_vwContentView RWsetChildHWidthAsConstraintWithMultiplier:0.66 view1:_btnBack view2:_webBody relatedBy:NSLayoutRelationLessThanOrEqual];
    } else {
        [_webBody setHidden:YES];
        _lblBody.text = _article.introtextWithoutHtml;
		[_vwContentView RWsetChildHWidthAsConstraintWithMultiplier:0.66 view1:_btnBack view2:_lblBody relatedBy:NSLayoutRelationLessThanOrEqual];
    }
	
	if(![_page hasChild:[RWPAGE RETURNBUTTON]] ||
	   ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
		[_btnBack RWsetHeightAsConstraint:0.0];
	} else if([[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]]){
		UIImage *btnImage = _btnBack.currentBackgroundImage;
		float aspect = btnImage.size.height/btnImage.size.width;
		[_btnBack addConstraint:[NSLayoutConstraint constraintWithItem:_btnBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_btnBack attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
	}
}

-(void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.label setTitleStyle:_lblTitle];

    [helper.label setBackTextStyle:_lblBody];

    [helper.button setBackButtonStyle:_btnBack];
	
	[helper setScrollBounces:_scrollview localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

-(void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]];
	
	if(!backButtonHasBackgroundImage){
		[helper setButtonText:_btnBack textName:[RWTEXT ADVENTWINDOW_BACKBUTTON] defaultText:[RWDEFAULTTEXT ADVENTWINDOW_BACKBUTTON]];
	}
}

-(IBAction)btnBackClicked{
    [_app.navController popPage];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_webBody RWSizeThatFitsContent];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
	
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
