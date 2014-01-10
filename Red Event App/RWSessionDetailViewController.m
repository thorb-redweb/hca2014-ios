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
			[_imgView setImageWithURL:_model.imageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]
							completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
								float imageHeight = image.size.height;
                                float aspectHeight = imageHeight * _imgView.frame.size.width / image.size.width;
                                [_imgView RWsetHeightAsConstraint:aspectHeight];
								}];
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

    [helper.label setColor:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblTitle localSizeName:[RWLOOK SESSIONDETAIL_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
    [helper.label setShadowColor:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];

    NSArray *labels = [[NSArray alloc] initWithObjects:_lblDate,_lblPlace,_lblTime, nil];
    [helper.label setColorsForList:labels localName:[RWLOOK SESSIONDETAIL_LABELCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFontsForList:labels localSizeName:[RWLOOK SESSIONDETAIL_LABELSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
                   localStyleName:[RWLOOK SESSIONDETAIL_LABELSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.label setShadowColorsForList:labels localName:[RWLOOK SESSIONDETAIL_LABELSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffsetsForList:labels localName:[RWLOOK SESSIONDETAIL_LABELSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

    NSArray *texts = [[NSArray alloc] initWithObjects:_lblDateText,_lblPlaceText,_lblTimeText, nil];
    [helper.label setColorsForList:texts localName:[RWLOOK SESSIONDETAIL_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFontsForList:texts localSizeName:[RWLOOK SESSIONDETAIL_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
                   localStyleName:[RWLOOK SESSIONDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper.label setShadowColorsForList:texts localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffsetsForList:texts localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper setBackgroundColor:_btnMap localName:[RWLOOK SESSIONDETAIL_BUTTONCOLOR] globalName:[RWLOOK DEFAULT_ALTCOLOR]];

    [helper.button setTitleColor:_btnMap localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btnMap localSizeName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE] localStyleName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper.button setTitleShadowColor:_btnMap localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btnMap localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper.button setImageFromLocalSource:_btnMap localName:[RWLOOK SESSIONDETAIL_BUTTONICON]];

    [helper.label setColor:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblBody localSizeName:[RWLOOK SESSIONDETAIL_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper.label setShadowColor:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper.button setBackgroundImageOrColor:_btnBack localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
    [helper.button setImageFromLocalSource:_btnBack localName:[RWLOOK BACKBUTTONICON]];
    [helper.button setTitleColor:_btnBack localName:[RWLOOK BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btnBack localSizeName:[RWLOOK BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btnBack localName:[RWLOOK BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btnBack localName:[RWLOOK BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	[helper setScrollBounces:_scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
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
}

- (IBAction)btnMapPressed:(id)sender {
    RWXmlNode *nextPage = [_xml getPage:_childname];
    [nextPage addNodeWithName:[RWPAGE SESSIONID] value:_model.sessionid];

    [_app.navController pushViewWithPage:nextPage];
}

-(IBAction)btnBackClicked{
	NSArray *constraints = self.view.constraints;
	constraints = [[NSArray alloc] init];
	
	UIScrollView *scrollView = _scrollView;
	CGSize size = scrollView.contentSize;
	NSArray *constraints2 = scrollView.constraints;
	constraints2 = [[NSArray alloc] init];
	size = CGSizeMake(0, 0);
	
    [_app.navController popPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
