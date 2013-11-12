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
	int _venueId;
	RWVenueVM *_venue;
}

- (id)initWithName:(NSString *)name venueId:(int)venueId
{
    self = [super initWithNibName:@"RWVenueDetailViewController" bundle:nil name:name];
    if (self) {
        _venueId = venueId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
	[self setAppearance];
	[self setText];
	[self applyModel];
}

-(void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
			
	[helper setBackgroundColor:self.view localName:[RWLOOK VENUEDETAIL_BACKGROUNDCOLOR] globalName:[RWLOOK GLOBAL_BACKCOLOR]];
	
	[helper setLabelColor:_lblTitle localName:[RWLOOK VENUEDETAIL_TITLECOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblTitle localSizeName:[RWLOOK VENUEDETAIL_TITLESIZE] globalSizeName:[RWLOOK GLOBAL_TITLESIZE] localStyleName:[RWLOOK VENUEDETAIL_TITLESTYLE] globalStyleName:[RWLOOK GLOBAL_TITLESTYLE]];
	[helper setLabelShadowColor:_lblTitle localName:[RWLOOK VENUEDETAIL_TITLESHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblTitle localName:[RWLOOK VENUEDETAIL_TITLESHADOWOFFSET] globalName:[RWLOOK GLOBAL_TITLESHADOWOFFSET]];
	
	[helper setLabelColor:_lblAddressLabel localName:[RWLOOK VENUEDETAIL_LABELCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblAddressLabel localSizeName:[RWLOOK VENUEDETAIL_LABELSIZE] globalSizeName:[RWLOOK GLOBAL_ITEMTITLESIZE] localStyleName:[RWLOOK VENUEDETAIL_LABELSTYLE] globalStyleName:[RWLOOK GLOBAL_ITEMTITLESTYLE]];
	[helper setLabelShadowColor:_lblAddressLabel localName:[RWLOOK VENUEDETAIL_LABELSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblAddressLabel localName:[RWLOOK VENUEDETAIL_LABELSHADOWOFFSET] globalName:[RWLOOK GLOBAL_ITEMTITLESHADOWOFFSET]];
	
	[helper setLabelColor:_lblAddressValue localName:[RWLOOK VENUEDETAIL_TEXTCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblAddressValue localSizeName:[RWLOOK VENUEDETAIL_TEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE] localStyleName:[RWLOOK VENUEDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
	[helper setLabelShadowColor:_lblAddressValue localName:[RWLOOK VENUEDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblAddressValue localName:[RWLOOK VENUEDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];

	[helper setBackgroundColor:_btnMap localName:[RWLOOK VENUEDETAIL_BUTTONCOLOR] globalName:[RWLOOK GLOBAL_ALTCOLOR]];
	[helper setButtonTitleColor:_btnMap forState:UIControlStateNormal localName:[RWLOOK VENUEDETAIL_BUTTONTEXTCOLOR] globalName:[RWLOOK GLOBAL_ALTTEXTCOLOR]];
    [helper setButtonTitleFont:_btnMap forState:UIControlStateNormal localSizeName:[RWLOOK VENUEDETAIL_BUTTONTEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE]
                localStyleName:[RWLOOK VENUEDETAIL_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
    [helper setButtonTitleShadowColor:_btnMap forState:UIControlStateNormal localName:[RWLOOK VENUEDETAIL_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_ALTTEXTSHADOWCOLOR]];
    [helper setButtonTitleShadowOffset:_btnMap forState:UIControlStateNormal localName:[RWLOOK VENUEDETAIL_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];
	
	[helper setLabelColor:_lblBody localName:[RWLOOK VENUEDETAIL_TEXTCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblBody localSizeName:[RWLOOK VENUEDETAIL_TEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE] localStyleName:[RWLOOK VENUEDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
	[helper setLabelShadowColor:_lblBody localName:[RWLOOK VENUEDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblBody localName:[RWLOOK VENUEDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];
}

-(void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblAddressLabel textName:[RWTEXT VENUEDETAIL_ADDRESS] defaultText:[RWDEFAULTTEXT VENUEDETAIL_ADDRESS]];
	[helper setButtonText:_btnMap textName:[RWTEXT VENUEDETAIL_MAPBUTTON] defaultText:[RWDEFAULTTEXT VENUEDETAIL_MAPBUTTON]];
}

-(void)applyModel{
	_venue = [_db.Venues getVMFromId:_venueId];
	
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

- (void)webViewDidFinishLoad:(UIWebView *)webView {    
    [_webBody RWSizeThatFitsContent];
    [_scrollView RWContentSizeToFit];
	
    _scrollView.bounces = NO;
}

- (IBAction)btnMapPressed:(id)sender{
	RWNode *childPage = [_xml getPage:_childname];
 	NSMutableDictionary *childDictionary = [NSMutableDictionary dictionaryWithDictionary:[childPage getDictionaryFromNode]];
	[childDictionary setValue:[NSNumber numberWithInt:_venue.venueid] forKey:[RWPAGE VENUEID]];
	[_app.navController pushViewWithParameters:childDictionary];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
