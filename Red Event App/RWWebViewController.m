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
	NSString *_url;
}

- (id)initWithName:(NSString *)name url:(NSString *)url
{
    self = [super initWithNibName:@"RWWebViewController" bundle:nil name:name];
    if (self) {
		_url = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self setAppearance];
    [self setText];

    NSURL* nsUrl = [NSURL URLWithString:_url];

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

    [helper setButtonBackgroundImageOrColor:_btnBack localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
    [helper setButtonImageFromLocalSource:_btnBack localName:[RWLOOK BACKBUTTONICON] forState:UIControlStateNormal];
    [helper setButtonTitleColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper setButtonTitleFont:_btnBack forState:UIControlStateNormal localSizeName:[RWLOOK BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setButtonTitleShadowColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper setButtonTitleShadowOffset:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
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
		NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary: [_page getDictionaryFromNode]];
		[dictionary removeObjectForKey:[RWPAGE URL]];
		NSString *url = [NSString stringWithFormat:@"%@/",inRequest.URL];
		[dictionary setValue:url forKey:[RWPAGE URL]];
		[_app.navController pushViewWithParameters:dictionary];
		
//		NSURL *nsUrl = inRequest.URL;
//		NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
//		[_webBody loadRequest:request];
        return NO;
    }
	
    return YES;
}

-(IBAction)btnBackClicked{
    [_app.navController popViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
