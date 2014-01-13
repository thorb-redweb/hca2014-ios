//
//  RWVenueDetailViewController.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIScrollView+RWScrollView.h"
#import "UIWebView+RWWebView.h"


#import "RWVenueDetailViewController.h"
#import "RWVenueVM.h"

@interface RWVenueDetailViewController ()

@end

@implementation RWVenueDetailViewController{
	RWVenueVM *_venue;
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWVenueDetailViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	if(![_xml swipeViewHasPage:_page]){
		[super.view setTranslatesAutoresizingMaskIntoConstraints:NO];
		_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	}
    
	[self setAppearance];
	[self setText];
	[self applyModel];
}

-(void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
			
	[helper setBackgroundColor:self.view localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

	[helper.label setTitleStyle:_lblTitle];

    [helper.label setColor:_lblAddressLabel localName:[RWLOOK VENUEDETAIL_LABELCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblAddressLabel localSizeName:[RWLOOK VENUEDETAIL_LABELSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK VENUEDETAIL_LABELSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.label setShadowColor:_lblAddressLabel localName:[RWLOOK VENUEDETAIL_LABELSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblAddressLabel localName:[RWLOOK VENUEDETAIL_LABELSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

	[helper.label setBackTextStyle:_lblAddressValue];

	[helper.button setButtonStyle:_btnMap];
	
	[helper.label setBackTextStyle:_lblBody];
	
	[helper setScrollBounces:_scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

-(void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblAddressLabel textName:[RWTEXT VENUEDETAIL_ADDRESS] defaultText:[RWDEFAULTTEXT VENUEDETAIL_ADDRESS]];
	[helper setButtonText:_btnMap textName:[RWTEXT VENUEDETAIL_MAPBUTTON] defaultText:[RWDEFAULTTEXT VENUEDETAIL_MAPBUTTON]];
}

-(void)applyModel{
    int venueId = [_page getIntegerFromNode:[RWPAGE VENUEID]];
	_venue = [_db.Venues getVMFromId:venueId];
	
	[_lblTitle setText:_venue.title];
	[_imgMain setImageWithURL:_venue.imageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];
	[_lblAddressValue setText:_venue.address];
	[_lblAddressValue sizeToFit];
	
	if([_page hasChild:[RWPAGE BODYUSESHTML]] && [_page getBoolFromNode:[RWPAGE BODYUSESHTML]]){
		[_lblBody setHidden:YES];
        [_webBody loadHTMLString:_venue.descriptionWithHtml baseURL:nil];
    } else {
        [_webBody setHidden:YES];
        _lblBody.text = _venue.descriptionWithoutHtml;
	}
}

- (IBAction)btnMapPressed:(id)sender{
	RWXmlNode *childPage = [_xml getPage:_childname];
    [childPage addNodeWithName:[RWPAGE VENUEID] value:[_page getStringFromNode:[RWPAGE VENUEID]]];
    [_app.navController pushViewWithPage:childPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
