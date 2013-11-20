//
//  RWNewstickerItem.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIView+RWViewLayout.h"

#import "RWNewstickerItem.h"
#import "RWArticleDetailViewController.h"

#import "RWAppDelegate.h"
#import "RWLOOK.h"
#import "RWAppearanceHelper.h"
#import "RWPAGE.h"

@implementation RWNewstickerItem {
	RWAppDelegate *_app;
    RWXMLStore *_xml;

    RWNode *_page;
}

- (id)initWithModel:(RWArticleVM *)model page:(RWNode *)page{
    if ([self initWithNibName:@"RWNewstickerItem" bundle:nil]) {
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        _model = model;
        _page = page;
        _app = [[UIApplication sharedApplication] delegate];
        _xml = _app.xml;
		
		//[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
		
		NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:150];
		[self.view addConstraints:[NSArray arrayWithObject:heightConstraint]];

		if ([_page hasChild:[RWPAGE BODYUSESHTML]] && [page getBoolFromNode:[RWPAGE BODYUSESHTML]]) {
			[_lblBody setHidden:YES];
		} else {
			[_webView setHidden:YES];
		}
		
		
        [self setAppearance];

        _lblTitle.text = model.title;
		_lblBody.text = model.introtextWithoutHtml;
        [_webView loadHTMLString:model.introtextWithHtml baseURL:nil];
        _webView.scrollView.scrollEnabled = NO;				
    }
    return self;
}

-(void)viewDidLayoutSubviews{	
	
	if ([_model.introImagePath length] != 0) {
		[_imgView setImageWithURL:_model.imageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];
//		if (_model.image != NULL) {
//			_imgView.image = _model.image;
//		}
//		else {
//			[_app.sv getImage:self imageLink:_model.imagePath wantedSize:CGSizeMake(_imgView.frame.size.width, 0)];//Should return an image of the given width and original aspect
//		}
	}
}

- (void)setConstraints {
	[self.view RWpinChildToSides:_lblTitle];
	[self.view RWpinChildToSides:_vwContentFrame];
	
	[_vwContentFrame RWpinChildToLeading:_imgView];
	[_vwContentFrame RWpinChildrenTogetherWithLeftChild:_imgView RightChild:_lblBody];
	[_vwContentFrame RWpinChildToTrailing:_lblBody];
	[_vwContentFrame RWpinChildrenTogetherWithLeftChild:_imgView RightChild:_webView];
	[_vwContentFrame RWpinChildToTrailing:_webView];

	[self.view RWpinChildToTop:_lblTitle];
	[self.view RWpinChildrenTogetherWithTopChild:_lblTitle BottomChild:_vwContentFrame];
	[self.view RWpinChildToBottom:_vwContentFrame];
	
	[_vwContentFrame RWpinChildToTop:_webView];
	[_vwContentFrame RWpinChildToBottom:_webView];
	
	[_vwContentFrame RWpinChildToTop:_lblBody];
	[_vwContentFrame RWpinChildToBottom:_lblBody];
	
	[_vwContentFrame RWpinChildToTop:_imgView];
	
	NSLayoutConstraint *pinConstraint1 = [NSLayoutConstraint constraintWithItem:_imgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_vwContentFrame attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0];
    [self.view addConstraints:[NSArray arrayWithObject:pinConstraint1]];
	
	NSLayoutConstraint *pinConstraint2 = [NSLayoutConstraint constraintWithItem:_imgView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_imgView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
    [self.view addConstraints:[NSArray arrayWithObject:pinConstraint2]];
	
    [self.view RWsetChildHWidthAsConstraintWithMultiplier:0.66 view1:_lblBody view2:self.view];
    [self.view RWsetChildHWidthAsConstraintWithMultiplier:0.66 view1:_webView view2:self.view];
    [self.view RWsetChildHWidthAsConstraintWithMultiplier:0.5 view1:_imgView view2:_webView relatedBy:NSLayoutRelationLessThanOrEqual];
}

- (void)setAppearance {

    RWNode *globalLook = [_xml.appearance getChildFromNode:[RWLOOK DEFAULT]];
    RWNode *localLook = [_xml.appearance getChildFromNode:[_page getStringFromNode:[RWPAGE NAME]]];

    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK NEWSTICKER_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
    [helper setBackgroundColor:_vwContentFrame localName:[RWLOOK NEWSTICKER_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
    [helper setLabelColor:_lblTitle localName:[RWLOOK NEWSTICKER_ITEMTITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblTitle localSizeName:[RWLOOK NEWSTICKER_ITEMTITLESIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
								   localStyleName:[RWLOOK NEWSTICKER_ITEMTITLESTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setLabelShadowColor:_lblTitle localName:[RWLOOK NEWSTICKER_ITEMTITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblTitle localName:[RWLOOK NEWSTICKER_ITEMTITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
    [helper setLabelColor:_lblBody localName:[RWLOOK NEWSTICKER_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblBody localSizeName:[RWLOOK NEWSTICKER_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
		  localStyleName:[RWLOOK NEWSTICKER_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setLabelShadowColor:_lblBody localName:[RWLOOK NEWSTICKER_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblBody localName:[RWLOOK NEWSTICKER_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}

- (void)getReturnImage:(UIImage *)image {
    _model.image = image;
    _imgView.image = image;
}

@end
