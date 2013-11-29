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
	
    _scrollview.bounces = NO;

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
	} else if([[_xml getAppearanceForPage:_name] hasChild:[RWLOOK ADVENTWINDOW_BACKBUTTONBACKGROUNDIMAGE]]){
		UIImage *btnImage = _btnBack.currentBackgroundImage;
		float aspect = btnImage.size.height/btnImage.size.width;
		[_btnBack addConstraint:[NSLayoutConstraint constraintWithItem:_btnBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_btnBack attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
	}
}

-(void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK ADVENTWINDOW_BACKGROUNDIMAGE] localColorName:[RWLOOK ADVENTWINDOW_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper setLabelColor:_lblTitle localName:[RWLOOK ADVENTWINDOW_TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblTitle localSizeName:[RWLOOK ADVENTWINDOW_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE] localStyleName:[RWLOOK ADVENTWINDOW_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
	[helper setLabelShadowColor:_lblTitle localName:[RWLOOK ADVENTWINDOW_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblTitle localName:[RWLOOK ADVENTWINDOW_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];
	
	[helper setLabelColor:_lblBody localName:[RWLOOK ADVENTWINDOW_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblBody localSizeName:[RWLOOK ADVENTWINDOW_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE] localStyleName:[RWLOOK ADVENTWINDOW_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
	[helper setLabelShadowColor:_lblBody localName:[RWLOOK ADVENTWINDOW_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblBody localName:[RWLOOK ADVENTWINDOW_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

	[helper setButtonBackgroundImageOrColor:_btnBack localImageName:[RWLOOK ADVENTWINDOW_BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK ADVENTWINDOW_BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	[helper setButtonImageFromLocalSource:_btnBack localName:[RWLOOK ADVENTWINDOW_BACKBUTTONICON] forState:UIControlStateNormal];
	[helper setButtonTitleColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK ADVENTWINDOW_BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btnBack forState:UIControlStateNormal localSizeName:[RWLOOK ADVENTWINDOW_BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK ADVENTWINDOW_BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK ADVENTWINDOW_BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btnBack forState:UIControlStateNormal localName:[RWLOOK ADVENTWINDOW_BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

-(void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK ADVENTWINDOW_BACKBUTTONBACKGROUNDIMAGE]];
	
	if(!backButtonHasBackgroundImage){
		[helper setButtonText:_btnBack textName:[RWTEXT ADVENTWINDOW_BACKBUTTON] defaultText:[RWDEFAULTTEXT ADVENTWINDOW_BACKBUTTON]];
	}
}

-(IBAction)btnBackClicked{
	[_app.navController popViewController];
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
