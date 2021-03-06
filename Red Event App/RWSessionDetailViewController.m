//
//  RWSessionDetailViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

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
    _lblTypeText.text = _model.type;
	_lblTypeText.textColor = _model.typeColor;
    _lblDateText.text = [NSString stringWithFormat:@"%@", _model.startDateLong];
    _lblPlaceText.text = [NSString stringWithFormat:@"%@", _model.venue];
    _lblTimeText.text = [NSString stringWithFormat:@"%@ - %@", _model.startTime, _model.endTime];

    if([_page hasChild:[RWPAGE BODYUSESHTML]] && [_page getBoolFromNode:[RWPAGE BODYUSESHTML]])
    {
        [_lblBody setHidden:YES];
        [_webBody loadHTMLString:_model.detailsWithHtml baseURL:nil];
    } else {
        [_webBody setHidden:YES];
		NSString *details = _model.details;
        _lblBody.text = details;
    }
	
	if ([_model.submissionPath isEqualToString:@""]) {
		[_btnTicket setHidden: YES];
		[_btnTicket setEnabled: YES];
		[_btnTicket RWsetHeightAsConstraint:0.0];
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

    [helper setBackgroundColor:self.view localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.label setTitleStyle:_lblTitle];

    [helper.label setBackTextStyle:_lblBody];

    [helper.button setBackButtonStyle:_btnBack];
	
	[helper setScrollBounces:_scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblDate textName:[RWTEXT SESSIONDETAIL_DATE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_DATE]];
	[helper setText:_lblPlace textName:[RWTEXT SESSIONDETAIL_PLACE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_PLACE]];
	[helper setText:_lblTime textName:[RWTEXT SESSIONDETAIL_TIME] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_TIME]];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]];
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

- (IBAction)btnTicketPressed:(id)sender{
	NSURL *submissionUrl = [NSURL URLWithString:_model.submissionPath];
	if (![[UIApplication sharedApplication] openURL:submissionUrl]) {
		DDLogCWarn(@"Failed to open url: %@", [submissionUrl description]);
	}
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
