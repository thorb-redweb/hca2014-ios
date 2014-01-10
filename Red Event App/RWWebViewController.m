//
//  RWWebViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWWebViewController.h"
#import "UIView+RWViewLayout.h"
#import "UIWebView+RWWebView.h"

@interface RWWebViewController ()

@end

@implementation RWWebViewController{
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWWebViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self setAppearance];
    [self setText];

    NSString * url = [_page getStringFromNode:[RWPAGE URL]];
    NSURL* nsUrl = [NSURL URLWithString:url];

    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];

    [_webBody loadRequest:request];

    if(![_page hasChild:[RWPAGE RETURNBUTTON]] || ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
        [_btnBack RWsetHeightAsConstraint:0.0];
    } else if([_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK ADVENTWINDOW_BACKBUTTONBACKGROUNDIMAGE]]){
        UIImage *btnImage = _btnBack.currentBackgroundImage;
        float aspect = btnImage.size.height/btnImage.size.width;
        [_btnBack addConstraint:[NSLayoutConstraint constraintWithItem:_btnBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_btnBack attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
    }
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.button setBackgroundImageOrColor:_btnBack localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
    [helper.button setImageFromLocalSource:_btnBack localName:[RWLOOK BACKBUTTONICON]];
    [helper.button setTitleColor:_btnBack localName:[RWLOOK BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btnBack localSizeName:[RWLOOK BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btnBack localName:[RWLOOK BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btnBack localName:[RWLOOK BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	[helper setScrollBounces:_webBody.scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

-(void)setText{
    RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];

    BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]];

    if(!backButtonHasBackgroundImage){
        [helper setButtonText:_btnBack textName:[RWTEXT WEBVIEW_BACKBUTTON] defaultText:[RWDEFAULTTEXT WEBVIEW_BACKBUTTON]];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[_webBody RWSizeThatFitsContent];
}

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if (inType == UIWebViewNavigationTypeLinkClicked) {
		RWXmlNode *nextPage = _page.deepClone;
        NSString *url = [NSString stringWithFormat:@"%@/",inRequest.URL];
		[nextPage replaceValueOfNodeWithName:[RWPAGE URL] value:url];
        [_app.navController pushViewWithPage:nextPage];
		
//		NSURL *nsUrl = inRequest.URL;
//		NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
//		[_webBody loadRequest:request];
        return NO;
    }
	
    return YES;
}

-(IBAction)btnBackClicked{
    [_app.navController popPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
