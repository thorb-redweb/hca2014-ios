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
        [_lblBody setHidden:YES];
		[_imgView setHidden:YES];
        [_webBody loadHTMLString:_model.fulltextWithHtml baseURL:nil];
		
		[_vwContentView RWsetChildHWidthAsConstraintWithMultiplier:0.66 view1:_btnBack view2:_webBody relatedBy:NSLayoutRelationLessThanOrEqual];
    } else {
        [_webBody setHidden:YES];
        _lblBody.text = _model.fulltextWithoutHtml;
		
		if (_model.mainImagePath && ![_model.mainImagePath isEqual:@""]) {
//			[_imgView setImageWithURL:_model.mainImageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];
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
		
		[_vwContentView RWsetChildHWidthAsConstraintWithMultiplier:0.66 view1:_btnBack view2:_lblBody relatedBy:NSLayoutRelationLessThanOrEqual];
    }
	
	if(![_page hasChild:[RWPAGE RETURNBUTTON]] ||
	   ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
		[_btnBack RWsetHeightAsConstraint:0.0];
	} else if([_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK ADVENTWINDOW_BACKBUTTONBACKGROUNDIMAGE]]){
		UIImage *btnImage = _btnBack.currentBackgroundImage;
		float aspect = btnImage.size.height/btnImage.size.width;
		[_btnBack addConstraint:[NSLayoutConstraint constraintWithItem:_btnBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_btnBack attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
	}
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
//	UIMotionEffectGroup *topGroup = [helper getTopMotionEffectGroup];
//	UIMotionEffectGroup *bottomGroup = [helper getBottomMotionEffectGroup];
	
	[helper setBackgroundTileImageOrColor:_imgBackground localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

//	[_imgBackground addMotionEffect:bottomGroup];

    [helper.label setColor:_lblTitle localName:[RWLOOK ARTICLEDETAIL_TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblTitle localSizeName:[RWLOOK ARTICLEDETAIL_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
           localStyleName:[RWLOOK ARTICLEDETAIL_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
    [helper.label setShadowColor:_lblTitle localName:[RWLOOK ARTICLEDETAIL_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblTitle localName:[RWLOOK ARTICLEDETAIL_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];
//	[_lblTitle addMotionEffect:topGroup];
	
//    [_imgView addMotionEffect:topGroup];

    [helper.label setColor:_lblBody localName:[RWLOOK ARTICLEDETAIL_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblBody localSizeName:[RWLOOK ARTICLEDETAIL_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
           localStyleName:[RWLOOK ARTICLEDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper.label setShadowColor:_lblBody localName:[RWLOOK ARTICLEDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblBody localName:[RWLOOK ARTICLEDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
//	[_lblBody addMotionEffect:topGroup];

    [helper.button setBackgroundImageOrColor:_btnBack localImageName:[RWLOOK ARTICLEDETAIL_BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK ARTICLEDETAIL_BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
    [helper.button setImageFromLocalSource:_btnBack localName:[RWLOOK ARTICLEDETAIL_BACKBUTTONICON]];
    [helper.button setTitleColor:_btnBack localName:[RWLOOK ARTICLEDETAIL_BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btnBack localSizeName:[RWLOOK ARTICLEDETAIL_BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK ARTICLEDETAIL_BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btnBack localName:[RWLOOK ARTICLEDETAIL_BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btnBack localName:[RWLOOK ARTICLEDETAIL_BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
//	[_btnBack addMotionEffect:topGroup];
	
	[helper setScrollBounces:_scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

-(void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK ARTICLEDETAIL_BACKBUTTONBACKGROUNDIMAGE]];
	
	if(!backButtonHasBackgroundImage){
		[helper setButtonText:_btnBack textName:[RWTEXT ARTICLEDETAIL_BACKBUTTON] defaultText:[RWDEFAULTTEXT ARTICLEDETAIL_BACKBUTTON]];
	}
}

- (void)getReturnImage:(UIImage *)image {
    _model.image = image;
    _imgView.image = image;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView RWSizeThatFitsContent];
}

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
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
