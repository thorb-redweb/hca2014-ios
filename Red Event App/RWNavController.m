//
//  RWNavController.m
//  hca2014
//
//  Created by Thorbjørn Steen on 3/3/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWNavController.h"
#import "RWAppDelegate.h"
#import "RWXMLStore.h"
#import "RWXmlNode.h"
#import "RWLOOK.h"
#import "RWPAGE.h"
#import "RWAppearanceHelper.h"

@implementation RWNavController{
	RWAppDelegate *_app;
	RWXMLStore *_xml;
}

- (id)initWithFrame:(CGRect)frame
{
	frame = CGRectMake(0, 0, 320, 44);
    self = [super initWithFrame:frame];
    if (self) {
        [self basicInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if(self = [super initWithCoder:aDecoder]){
		[self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"RWNavController" owner:self options:nil] objectAtIndex:0]];
        [self basicInit];
	}
	return self;
}

- (void)basicInit{
	_app = [[UIApplication sharedApplication] delegate];
	_xml = _app.xml;
	if(![_app.navController hasPreviousPage]){
		_btnBack.hidden = true;
	}
}

- (void)setAppearance{
	RWXmlNode *defaultLook = [_xml getAppearanceForPage:[RWLOOK DEFAULT]];
	RWXmlNode *localLook = nil;
	if ([_xml.appearance hasChild:[RWLOOK NAVIGATIONBAR]]) {
		localLook = [_xml getAppearanceForPage:[RWLOOK NAVIGATIONBAR]];
		if([localLook hasChild:[RWLOOK NAVBAR_VISIBLE]] && ![localLook getBoolFromNode:[RWLOOK NAVBAR_VISIBLE]]){
			[self setHidden:YES];
		}
	}
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:defaultLook];
	[helper setBackgroundTileImageOrColor:self localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BARCOLOR]];
	
	if(localLook != nil && [localLook getBoolWithNoneAsFalse:[RWLOOK NAVBAR_HASTITLE]]){
		_lblTitle.hidden = FALSE;
		[helper.label setColor:_lblTitle localName:[RWLOOK NAVBAR_TITLECOLOR] globalName:[RWLOOK DEFAULT_BARTEXTCOLOR]];
		[helper.label setFont:_lblTitle localSizeName:[RWLOOK NAVBAR_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE] localStyleName:[RWLOOK NAVBAR_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
		[helper.label setShadowColor:_lblTitle localName:[RWLOOK NAVBAR_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BARTEXTSHADOWCOLOR]];
		[helper.label setShadowOffset:_lblTitle localName:[RWLOOK NAVBAR_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];
	}
}

-(void)handleNewPage:(RWXmlNode *)page{
	if(![_app.navController hasPreviousPage]){
		_btnBack.hidden = true;
	}
	else{
		_btnBack.hidden = false;
//		NSString *title = [page getStringFromNode:[RWPAGE NAME]];
//		[_btnBack.titleLabel setText:title];
	}
}

-(IBAction)btnHomePushed{
	RWXmlNode *frontpage = [_xml getFrontPage];
	[_app.navController pushViewWithPage:frontpage];
}

-(IBAction)btnBackPushed{
	[_app.navController popPage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
