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
    int _pushmessageid;
    RWPushMessageVM *_pushMessage;
}

- (id)initWithName:(NSString *)name pushmessageid:(int)pushmessageid
{
    self = [super initWithNibName:@"RWPushMessageDetailViewController" bundle:nil name:name];
    if (self) {
        _pushmessageid = pushmessageid;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self setAppearance];
    [self setText];

    _pushMessage = [_db.PushMessages getVMFromId:_pushmessageid];

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

    [helper setLabelColor:_lblIntro localName:[RWLOOK TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblIntro localSizeName:[RWLOOK TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
          localStyleName:[RWLOOK TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
    [helper setLabelShadowColor:_lblIntro localName:[RWLOOK TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblIntro localName:[RWLOOK TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];

    [helper setLabelColor:_lblAuthor localName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblAuthor localSizeName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
          localStyleName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setLabelShadowColor:_lblAuthor localName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblAuthor localName:[RWLOOK PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

    [helper setLabelColor:_lblSenddate localName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblSenddate localSizeName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
          localStyleName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setLabelShadowColor:_lblSenddate localName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblSenddate localName:[RWLOOK PUSHMESSAGEDETAIL_SENTTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

    [helper setLabelColor:_lblMessage localName:[RWLOOK TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblMessage localSizeName:[RWLOOK TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
          localStyleName:[RWLOOK TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setLabelShadowColor:_lblMessage localName:[RWLOOK TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblMessage localName:[RWLOOK TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper setButtonBackgroundImageOrColor:_btnBack localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
    [helper setButtonImageFromLocalSource:_btnBack localName:[RWLOOK BACKBUTTONICON] forState:UIControlStateNormal];
    [helper setButtonTitleColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper setButtonTitleFont:_btnBack forState:UIControlStateNormal localSizeName:[RWLOOK BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setButtonTitleShadowColor:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper setButtonTitleShadowOffset:_btnBack forState:UIControlStateNormal localName:[RWLOOK BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

-(void)setText{
    RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];

    BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]];

    if(!backButtonHasBackgroundImage){
        [helper setButtonText:_btnBack textName:[RWTEXT PUSHMESSAGEDETAIL_BACKBUTTON] defaultText:[RWDEFAULTTEXT PUSHMESSAGEDETAIL_BACKBUTTON]];
    }
}

-(IBAction)btnBackClicked{
    [_app.navController popViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
