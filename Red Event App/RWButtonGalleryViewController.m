//
//  RWButtonGalleryViewController.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWButtonGalleryViewController.h"
#import "RWXmlNode.h"

#import "RWPAGE.h"

@interface RWButtonGalleryViewController ()

@end

@implementation RWButtonGalleryViewController

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWButtonGalleryViewController" bundle:nil page:page];
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
    
	if ([_page hasChild:[RWPAGE BUTTON1CHILD]]) {[_btn1 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON2CHILD]]) {[_btn2 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON3CHILD]]) {[_btn3 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON4CHILD]]) {[_btn4 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON5CHILD]]) {[_btn5 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON6CHILD]]) {[_btn6 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON7CHILD]]) {[_btn7 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON8CHILD]]) {[_btn8 setHidden:false];}
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
    [helper setBackgroundColor:self.view localName:[RWLOOK STATICARTICLE_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	bool hasUniqueImage1 = [helper.button setBackgroundImageFromLocalSource:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE]];
	if (!hasUniqueImage1) {
        [helper.button setBackgroundImageOrColor:_btn1 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON1ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTON1ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn1 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage2 = [helper.button setBackgroundImageFromLocalSource:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTON2BACKGROUNDIMAGE]];
	if (!hasUniqueImage2) {
        [helper.button setBackgroundImageOrColor:_btn2 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON2ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTON2ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn2 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage3 = [helper.button setBackgroundImageFromLocalSource:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE]];
	if (!hasUniqueImage3) {
        [helper.button setBackgroundImageOrColor:_btn3 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON3ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTON3ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn3 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage4 = [helper.button setBackgroundImageFromLocalSource:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTON4BACKGROUNDIMAGE]];
	if (!hasUniqueImage4) {
        [helper.button setBackgroundImageOrColor:_btn4 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON4ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTON4ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn4 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage5 = [helper.button setBackgroundImageFromLocalSource:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTON5BACKGROUNDIMAGE]];
	if (!hasUniqueImage5) {
        [helper.button setBackgroundImageOrColor:_btn5 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON5ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTON5ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn5 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage6 = [helper.button setBackgroundImageFromLocalSource:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE]];
	if (!hasUniqueImage6) {
        [helper.button setBackgroundImageOrColor:_btn6 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON6ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTON6ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn6 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage7 = [helper.button setBackgroundImageFromLocalSource:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTON7BACKGROUNDIMAGE]];
	if (!hasUniqueImage7) {
        [helper.button setBackgroundImageOrColor:_btn7 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON7ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTON7ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn7 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage8 = [helper.button setBackgroundImageFromLocalSource:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTON8BACKGROUNDIMAGE]];
	if (!hasUniqueImage8) {
        [helper.button setBackgroundImageOrColor:_btn8 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON8ICON]]) {
        [helper.button setBackgroundImageFromLocalSource:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTON8ICON]];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
        [helper.button setBackgroundImageFromLocalSource:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTONICON]];
	}
    [helper.button setTitleColor:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFont:_btn8 localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColor:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffset:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	NSString *defaultText;
	
	if([_page hasChild:[RWPAGE BUTTON1CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON1CHILD]];
		[helper setButtonText:_btn1 textName:[RWTEXT BUTTONGALLERY_BUTTON1] defaultText:defaultText];
	}
	
	if([_page hasChild:[RWPAGE BUTTON2CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON2CHILD]];
		[helper setButtonText:_btn2 textName:[RWTEXT BUTTONGALLERY_BUTTON2] defaultText:defaultText];
	}
	
	
	if([_page hasChild:[RWPAGE BUTTON3CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON3CHILD]];
		[helper setButtonText:_btn3 textName:[RWTEXT BUTTONGALLERY_BUTTON3] defaultText:defaultText];
	}
	
	
	if([_page hasChild:[RWPAGE BUTTON4CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON4CHILD]];
		[helper setButtonText:_btn4 textName:[RWTEXT BUTTONGALLERY_BUTTON4] defaultText:defaultText];
	}
	
	
	if([_page hasChild:[RWPAGE BUTTON5CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON5CHILD]];
		[helper setButtonText:_btn5 textName:[RWTEXT BUTTONGALLERY_BUTTON5] defaultText:defaultText];
	}
	
	
	if([_page hasChild:[RWPAGE BUTTON6CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON6CHILD]];
		[helper setButtonText:_btn6 textName:[RWTEXT BUTTONGALLERY_BUTTON6] defaultText:defaultText];
	}
	
	
	if([_page hasChild:[RWPAGE BUTTON7CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON7CHILD]];
		[helper setButtonText:_btn7 textName:[RWTEXT BUTTONGALLERY_BUTTON7] defaultText:defaultText];
	}
	
	
	if([_page hasChild:[RWPAGE BUTTON8CHILD]]){
		defaultText = [_page getStringFromNode:[RWPAGE BUTTON8CHILD]];
		[helper setButtonText:_btn8 textName:[RWTEXT BUTTONGALLERY_BUTTON8] defaultText:defaultText];
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn1Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON1CHILD]];
}

-(void)btn2Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON2CHILD]];
}

-(void)btn3Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON3CHILD]];
}

-(void)btn4Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON4CHILD]];
}

-(void)btn5Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON5CHILD]];
}

-(void)btn6Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON6CHILD]];
}

-(void)btn7Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON7CHILD]];
}

-(void)btn8Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON8CHILD]];
}

-(void)goToNextPage:(NSString *)button{
	if ([_page hasChild:button]) {
		RWXmlNode *nextPage = [_xml getPage:[_page getStringFromNode:button]];
        [_app.navController pushViewWithPage:nextPage];
	}
}

@end
