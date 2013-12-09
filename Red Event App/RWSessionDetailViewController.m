//
//  RWSessionDetailViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIScrollView+RWScrollView.h"
#import "UIView+RWViewLayout.h"
#import "UIWebView+RWWebView.h"

#import "RWSessionDetailViewController.h"

#import "RWAppDelegate.h"
#import "RWServer.h"
#import "RWDbInterface.h"

#import "RWSessionVM.h"


@interface RWSessionDetailViewController ()

@end

@implementation RWSessionDetailViewController {
    RWSessionVM *_model;
}


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWSessionDetailViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

	[self setAppearance];
	[self setText];

    int sessionId = [_page getIntegerFromNode:[RWPAGE SESSIONID]];
    _model = [_db.Sessions getVMFromId:sessionId];
	
	_lblTitle.text = _model.title;
    _lblDateText.text = [NSString stringWithFormat:@"%@", _model.startDateLong];
    _lblPlaceText.text = [NSString stringWithFormat:@"%@", _model.venue];
    _lblTimeText.text = [NSString stringWithFormat:@"%@ - %@", _model.startTime, _model.endTime];

    if([_page hasChild:[RWPAGE BODYUSESHTML]] && [_page getBoolFromNode:[RWPAGE BODYUSESHTML]])
    {
        [_lblBody setHidden:YES];
        [_webBody loadHTMLString:_model.detailsWithHtml baseURL:nil];
    } else {
        [_webBody setHidden:YES];
        _lblBody.text = _model.details;
    }

    if ([_model.imagePath length] != 0) {
        if (_model.image != NULL) {
            _imgView.image = _model.image;
        }
        else {
			[_imgView setImageWithURL:_model.imageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];
        }
    }
	
	if(![_page hasChild:[RWPAGE RETURNBUTTON]] ||
	   ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
		[_btnBack RWsetHeightAsConstraint:0.0];
	}
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK SESSIONDETAIL_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
    [helper setLabelColor:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblTitle localSizeName:[RWLOOK SESSIONDETAIL_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
          localStyleName:[RWLOOK SESSIONDETAIL_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
	[helper setLabelShadowColor:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];

    NSArray *labels = [[NSArray alloc] initWithObjects:_lblDate,_lblPlace,_lblTime, nil];
    [helper setLabelColors:labels localName:[RWLOOK SESSIONDETAIL_LABELCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFonts:labels localSizeName:[RWLOOK SESSIONDETAIL_LABELSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_LABELSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setLabelShadowColors:labels localName:[RWLOOK SESSIONDETAIL_LABELSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffsets:labels localName:[RWLOOK SESSIONDETAIL_LABELSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

    NSArray *texts = [[NSArray alloc] initWithObjects:_lblDateText,_lblPlaceText,_lblTimeText, nil];
    [helper setLabelColors:texts localName:[RWLOOK SESSIONDETAIL_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFonts:texts localSizeName:[RWLOOK SESSIONDETAIL_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setLabelShadowColors:texts localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffsets:texts localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper setBackgroundColor:_btnMap localName:[RWLOOK SESSIONDETAIL_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_ALTCOLOR]];

    [helper setButtonTitleColor:_btnMap forState:UIControlStateNormal localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper setButtonTitleFont:_btnMap forState:UIControlStateNormal localSizeName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
                localStyleName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setButtonTitleShadowColor:_btnMap forState:UIControlStateNormal localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper setButtonTitleShadowOffset:_btnMap forState:UIControlStateNormal localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper setButtonImageFromLocalSource:_btnMap localName:[RWLOOK SESSIONDETAIL_BUTTONICON] forState:UIControlStateNormal];

    [helper setLabelColor:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblBody localSizeName:[RWLOOK SESSIONDETAIL_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setLabelShadowColor:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
	
	[helper setButtonBackgroundImageOrColor:_btnBack localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	[helper setButtonImageFromLocalSource:_btnBack localName:[RWLOOK BACKBUTTONICON] forState:UIControlStateNormal];
	[helper setButtonTitleColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btnBack forState:UIControlStateNormal localSizeName:[RWLOOK BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblDate textName:[RWTEXT SESSIONDETAIL_DATE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_DATE]];
	[helper setText:_lblPlace textName:[RWTEXT SESSIONDETAIL_PLACE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_PLACE]];
	[helper setText:_lblTime textName:[RWTEXT SESSIONDETAIL_TIME] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_TIME]];
	[helper setButtonText:_btnMap textName:[RWTEXT SESSIONDETAIL_MAPBUTTON] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_MAPBUTTON]];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK MAPVIEW_BACKBUTTONBACKGROUNDIMAGE]];
	if(!backButtonHasBackgroundImage){
		[helper setButtonText:_btnBack textName:[RWTEXT MAPVIEW_BACKBUTTON] defaultText:[RWDEFAULTTEXT MAPVIEW_BACKBUTTON]];
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_lblTime sizeToFit];

    [webView RWSizeThatFitsContent];
    [_scrollView RWContentSizeToFit];

    _scrollView.bounces = NO;
}

- (IBAction)btnMapPressed:(id)sender {
    RWXmlNode *nextPage = [_xml getPage:_childname];
    [nextPage addNodeWithName:[RWPAGE SESSIONID] value:_model.sessionid];

    [_app.navController pushViewWithPage:nextPage];
}

-(IBAction)btnBackClicked{
	[_app.navController popViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
