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
#import "UIWebView+RWWebView.h"

#import "RWSessionDetailViewController.h"

#import "RWAppDelegate.h"
#import "RWServer.h"
#import "RWDbInterface.h"

#import "RWSessionVM.h"


@interface RWSessionDetailViewController ()

@end

@implementation RWSessionDetailViewController {
    int _sessionid;
    RWSessionVM *_model;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil sessionid:(int)sessionid name:(NSString *)name {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil name:name];
    if (self) {
        _sessionid = sessionid;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self setAppearance];
	[self setText];
	
    _model = [_db.Sessions getVMFromId:_sessionid];
	
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
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK SESSIONDETAIL_BACKGROUNDCOLOR] globalName:[RWLOOK GLOBAL_BACKCOLOR]];
	
    [helper setLabelColor:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLECOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblTitle localSizeName:[RWLOOK SESSIONDETAIL_TITLESIZE] globalSizeName:[RWLOOK GLOBAL_TITLESIZE]
          localStyleName:[RWLOOK SESSIONDETAIL_TITLESTYLE] globalStyleName:[RWLOOK GLOBAL_TITLESTYLE]];
	[helper setLabelShadowColor:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLESHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblTitle localName:[RWLOOK SESSIONDETAIL_TITLESHADOWOFFSET] globalName:[RWLOOK GLOBAL_TITLESHADOWOFFSET]];

    NSArray *labels = [[NSArray alloc] initWithObjects:_lblDate,_lblPlace,_lblTime, nil];
    [helper setLabelColors:labels localName:[RWLOOK SESSIONDETAIL_LABELCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
    [helper setLabelFonts:labels localSizeName:[RWLOOK SESSIONDETAIL_LABELSIZE] globalSizeName:[RWLOOK GLOBAL_ITEMTITLESIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_LABELSTYLE] globalStyleName:[RWLOOK GLOBAL_ITEMTITLESTYLE]];
    [helper setLabelShadowColors:labels localName:[RWLOOK SESSIONDETAIL_LABELSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffsets:labels localName:[RWLOOK SESSIONDETAIL_LABELSHADOWOFFSET] globalName:[RWLOOK GLOBAL_ITEMTITLESHADOWOFFSET]];

    NSArray *texts = [[NSArray alloc] initWithObjects:_lblDateText,_lblPlaceText,_lblTimeText, nil];
    [helper setLabelColors:texts localName:[RWLOOK SESSIONDETAIL_TEXTCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
    [helper setLabelFonts:texts localSizeName:[RWLOOK SESSIONDETAIL_TEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
    [helper setLabelShadowColors:texts localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffsets:texts localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];

    [helper setBackgroundColor:_btnMap localName:[RWLOOK SESSIONDETAIL_BACKGROUNDCOLOR] globalName:[RWLOOK GLOBAL_ALTCOLOR]];

    [helper setButtonTitleColor:_btnMap forState:UIControlStateNormal localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTCOLOR] globalName:[RWLOOK GLOBAL_ALTTEXTCOLOR]];
    [helper setButtonTitleFont:_btnMap forState:UIControlStateNormal localSizeName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE]
                localStyleName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
    [helper setButtonTitleShadowColor:_btnMap forState:UIControlStateNormal localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_ALTTEXTSHADOWCOLOR]];
    [helper setButtonTitleShadowOffset:_btnMap forState:UIControlStateNormal localName:[RWLOOK SESSIONDETAIL_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];

    [helper setButtonImageFromLocalSource:_btnMap localName:[RWLOOK SESSIONDETAIL_MAPBUTTONIMAGE] forState:UIControlStateNormal];

    [helper setLabelColor:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblBody localSizeName:[RWLOOK SESSIONDETAIL_TEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE]
           localStyleName:[RWLOOK SESSIONDETAIL_TEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
    [helper setLabelShadowColor:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblBody localName:[RWLOOK SESSIONDETAIL_TEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblDate textName:[RWTEXT SESSIONDETAIL_DATE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_DATE]];
	[helper setText:_lblPlace textName:[RWTEXT SESSIONDETAIL_PLACE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_PLACE]];
	[helper setText:_lblTime textName:[RWTEXT SESSIONDETAIL_TIME] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_TIME]];
	[helper setButtonText:_btnMap textName:[RWTEXT SESSIONDETAIL_MAPBUTTON] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_MAPBUTTON]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_lblTime sizeToFit];

    [webView RWSizeThatFitsContent];
    [_scrollView RWContentSizeToFit];

    _scrollView.bounces = NO;
}

- (IBAction)btnMapPressed:(id)sender {
    RWAppDelegate *app = [[UIApplication sharedApplication] delegate];

    NSMutableDictionary *sessionmapVariables = [[NSMutableDictionary alloc] init];
    [sessionmapVariables setObject:[RWTYPE SESSIONMAP] forKey:[RWPAGE TYPE]];
    [sessionmapVariables setObject:_childname forKey:[RWPAGE NAME]];
    [sessionmapVariables setObject:_model.sessionid forKey:[RWPAGE SESSIONID]];

    [app.navController pushViewWithParameters:sessionmapVariables];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
