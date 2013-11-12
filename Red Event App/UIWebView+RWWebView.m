//
//  UIWebView+RWWebView.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/12/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"
#import "UIWebView+RWWebView.h"


@implementation UIWebView (RWWebView)

- (void)RWSizeThatFitsContent {
    UIWebView *webView = self;

    webView.scrollView.scrollEnabled = NO;
	
    CGSize contentSize = webView.scrollView.contentSize;
    [webView RWsetHeightAsConstraint:contentSize.height];
}

@end
