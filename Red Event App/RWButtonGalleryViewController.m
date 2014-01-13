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
	
    [helper setBackgroundColor:self.view localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    NSArray *buttons = [NSArray arrayWithObjects:_btn1,_btn2,_btn3,_btn4,_btn5,_btn6,_btn7,_btn8,nil];
    NSArray *BUTTONBACKGROUNDIMAGELOCALNAMES = [NSArray arrayWithObjects:[RWLOOK BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE],[RWLOOK BUTTONGALLERY_BUTTON2BACKGROUNDIMAGE],
                    [RWLOOK BUTTONGALLERY_BUTTON3BACKGROUNDIMAGE],[RWLOOK BUTTONGALLERY_BUTTON4BACKGROUNDIMAGE],[RWLOOK BUTTONGALLERY_BUTTON5BACKGROUNDIMAGE],
                    [RWLOOK BUTTONGALLERY_BUTTON6BACKGROUNDIMAGE],[RWLOOK BUTTONGALLERY_BUTTON7BACKGROUNDIMAGE],[RWLOOK BUTTONGALLERY_BUTTON8BACKGROUNDIMAGE],nil];
    NSArray *BUTTONICONLOCALNAMES = [NSArray arrayWithObjects:[RWLOOK BUTTONGALLERY_BUTTON1ICON],[RWLOOK BUTTONGALLERY_BUTTON2ICON],
                                                                         [RWLOOK BUTTONGALLERY_BUTTON3ICON],[RWLOOK BUTTONGALLERY_BUTTON4ICON],[RWLOOK BUTTONGALLERY_BUTTON5ICON],
                                                                         [RWLOOK BUTTONGALLERY_BUTTON6ICON],[RWLOOK BUTTONGALLERY_BUTTON7ICON],[RWLOOK BUTTONGALLERY_BUTTON8ICON],nil];

    for(int i = 0; i < buttons.count; i++){
        UIButton *button = buttons[i];

        bool hasUniqueImage = [helper.button setBackgroundImageFromLocalSource:button localName:BUTTONBACKGROUNDIMAGELOCALNAMES[i]];
        if (!hasUniqueImage) {
            [helper.button setBackgroundImageOrColor:button localImageName:[RWLOOK BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
        }
        bool hasUniqueIcon = [helper.button setBackgroundImageFromLocalSource:button localName:BUTTONICONLOCALNAMES[i]];
        if(!hasUniqueIcon && [helper.getter pageHasLocalName:[RWLOOK BUTTONICON]]){
            [helper.button setBackgroundImageFromLocalSource:button localName:[RWLOOK BUTTONICON]];
        }

        [helper.button setTitleColor:button localName:[RWLOOK BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
        [helper.button setTitleFont:button localSizeName:[RWLOOK BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
        [helper.button setTitleShadowColor:button localName:[RWLOOK BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
        [helper.button setTitleShadowOffset:button localName:[RWLOOK BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
    }
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
