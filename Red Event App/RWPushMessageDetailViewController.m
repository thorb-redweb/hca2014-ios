//
//  RWPushMessageDetailViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWPushMessageDetailViewController.h"
#import "RWPushMessageVM.h"
#import "RWDbPushMessages.h"

@interface RWPushMessageDetailViewController ()

@end

@implementation RWPushMessageDetailViewController{
    RWPushMessageVM *_pushMessage;
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWPushMessageDetailViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self setAppearance];
    [self setText];

    int pushmessageId = [_page getIntegerFromNode:[RWPAGE PUSHMESSAGEID]];
    _pushMessage = [_db.PushMessages getVMFromId:pushmessageId];

    _lblIntro.text = _pushMessage.intro;
    _lblAuthor.text = _pushMessage.author;
    _lblSenddate.text = [_pushMessage senddateWithPattern:@"yyyy-MM-dd"];
    _lblMessage.text = [_pushMessage message];

    if(![_page hasChild:[RWPAGE RETURNBUTTON]] ||
            ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
        [_btnBack RWsetHeightAsConstraint:0.0];
    } else if([_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]]){
        UIImage *btnImage = _btnBack.currentBackgroundImage;
        float aspect = btnImage.size.height/btnImage.size.width;
        [_btnBack addConstraint:[NSLayoutConstraint constraintWithItem:_btnBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_btnBack attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
    }
}

-(void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.label setColor:_lblIntro localName:[RWLOOK TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblIntro localSizeName:[RWLOOK TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
           localStyleName:[RWLOOK TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
    [helper.label setShadowColor:_lblIntro localName:[RWLOOK TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblIntro localName:[RWLOOK TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];

    [helper.label setColor:_lblAuthor localName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblAuthor localSizeName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
           localStyleName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.label setShadowColor:_lblAuthor localName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblAuthor localName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

    [helper.label setColor:_lblSenddate localName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblSenddate localSizeName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
           localStyleName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.label setShadowColor:_lblSenddate localName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblSenddate localName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

    [helper.label setColor:_lblMessage localName:[RWLOOK TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:_lblMessage localSizeName:[RWLOOK TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
           localStyleName:[RWLOOK TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper.label setShadowColor:_lblMessage localName:[RWLOOK TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:_lblMessage localName:[RWLOOK TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper.button setBackgroundImageOrColor:_btnBack localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
    [helper.button setImageFromLocalSource:_btnBack localName:[RWLOOK BACKBUTTONICON]];
    [helper.button setTitleColor:_btnBack localName:[RWLOOK BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btnBack localSizeName:[RWLOOK BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btnBack localName:[RWLOOK BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btnBack localName:[RWLOOK BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

-(void)setText{
    RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];

    BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]];

    if(!backButtonHasBackgroundImage){
        [helper setButtonText:_btnBack textName:[RWTEXT PUSHMESSAGEDETAIL_BACKBUTTON] defaultText:[RWDEFAULTTEXT PUSHMESSAGEDETAIL_BACKBUTTON]];
    }
}

-(IBAction)btnBackClicked{
    [_app.navController popPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
