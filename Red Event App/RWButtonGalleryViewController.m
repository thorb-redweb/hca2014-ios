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
	
	bool hasUniqueImage1 = [helper setButtonBackgroundImageFromLocalSource:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage1) {
			[helper setButtonBackgroundImageOrColor:_btn1 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON1ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTON1ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn1 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn1 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn1 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn1 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn1 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage2 = [helper setButtonBackgroundImageFromLocalSource:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTON2BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage2) {
		[helper setButtonBackgroundImageOrColor:_btn2 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON2ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTON2ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn2 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn2 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn2 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn2 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn2 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage3 = [helper setButtonBackgroundImageFromLocalSource:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage3) {
		[helper setButtonBackgroundImageOrColor:_btn3 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON3ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTON3ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn3 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn3 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn3 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn3 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn3 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage4 = [helper setButtonBackgroundImageFromLocalSource:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTON4BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage4) {
		[helper setButtonBackgroundImageOrColor:_btn4 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON4ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTON4ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn4 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn4 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn4 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn4 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn4 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage5 = [helper setButtonBackgroundImageFromLocalSource:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTON5BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage5) {
		[helper setButtonBackgroundImageOrColor:_btn5 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON5ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTON5ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn5 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn5 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn5 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn5 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn5 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage6 = [helper setButtonBackgroundImageFromLocalSource:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage6) {
		[helper setButtonBackgroundImageOrColor:_btn6 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON6ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTON6ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn6 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn6 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn6 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn6 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn6 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage7 = [helper setButtonBackgroundImageFromLocalSource:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTON7BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage7) {
		[helper setButtonBackgroundImageOrColor:_btn7 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON7ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTON7ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn7 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn7 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn7 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn7 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn7 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
	bool hasUniqueImage8 = [helper setButtonBackgroundImageFromLocalSource:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTON8BACKGROUNDIMAGE] forState:UIControlStateNormal];
	if (!hasUniqueImage8) {
		[helper setButtonBackgroundImageOrColor:_btn8 localImageName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONGALLERY_BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR] forState:UIControlStateNormal];
	}
	if ([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTON8ICON]]) {
		[helper setButtonBackgroundImageFromLocalSource:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTON8ICON] forState:UIControlStateNormal];
	}
	if([_localLook hasChild:[RWLOOK BUTTONGALLERY_BUTTONICON]]){
		[helper setButtonBackgroundImageFromLocalSource:_btn8 localName:[RWLOOK BUTTONGALLERY_BUTTONICON] forState:UIControlStateNormal];
	}
	[helper setButtonTitleColor:_btn8 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	[helper setButtonTitleFont:_btn8 forState:UIControlStateNormal localSizeName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper setButtonTitleShadowColor:_btn8 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
	[helper setButtonTitleShadowOffset:_btn8 forState:UIControlStateNormal localName:[RWLOOK BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
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
		[_app.navController pushViewWithParameters:nextPage];
	}
}

@end
