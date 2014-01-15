//
//  RWButtonAppearanceForwarder.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWButtonAppearanceForwarder.h"

#import "RWButtonAppearanceHelper.h"
#import "RWApperanceHelperGetter.h"

#import "RWLOOK.h"

@implementation RWButtonAppearanceForwarder{
	RWApperanceHelperGetter *getter;
	RWButtonAppearanceHelper *buttonHelper;
	
	UIButton *lastChangedButton;
	NSArray *lastChangedButtonList;
}

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter{
	if(self = [super init]){
		buttonHelper = [[RWButtonAppearanceHelper alloc] initWithHelper:apperanceHelper Getter:appearanceGetter];
		getter = appearanceGetter;
	}
	return self;
}

- (void)setActive:(UIButton *)button{
    lastChangedButton = button;
}

- (void)setActiveList:(NSArray *)buttonList{
    lastChangedButtonList = buttonList;
}

- (void)setBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName{
    [buttonHelper setBackgroundImageOrColor:button localImageName:localImageName localColorName:localColorName globalColorName:globalColorName forState:UIControlStateNormal];
}

- (void)setBackgroundImageOrColorForLast:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName{
    [self setBackgroundImageOrColor:lastChangedButton localImageName:localImageName localColorName:localColorName globalColorName:globalColorName];
}

- (void)setBackgroundImageOrColorsForList:(NSArray *)buttons localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName {
    for(UIButton *button in buttons){
		[self setBackgroundImageOrColor:button localImageName:localImageName localColorName:localColorName globalColorName:globalColorName];
	}
}

- (void)setBackgroundImageOrColorsForLastList:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName {
    [self setBackgroundImageOrColorsForList:lastChangedButtonList localImageName:localImageName localColorName:localColorName globalColorName:globalColorName];
}

- (BOOL)setBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname{
    return [buttonHelper setBackgroundImageFromLocalSource:button localName:localname forState:UIControlStateNormal];
}

- (BOOL)setBackgroundImageFromLocalSourceForLast:(NSString *)localname {
    return  [self setBackgroundImageFromLocalSource:lastChangedButton localName:localname];
}

- (void)setImageFromLocalSource:(UIButton *)button localName:(NSString *)localname{
    [buttonHelper setImageFromLocalSource:button localName:localname forState:UIControlStateNormal];
}

- (void)setImageFromLocalSourceForLast:(NSString *)localname {
    [self setImageFromLocalSource:lastChangedButton localName:localname];
}

- (void)setImageFromLocalSourcesForList:(NSArray *)buttons localName:(NSString *)localname {
	for(UIButton *button in buttons){
		[self setImageFromLocalSource:button localName:localname];
	}
}

- (void)setImageFromLocalSourcesForLastList:(NSString *)localname {
    [self setImageFromLocalSourcesForList:lastChangedButtonList localName:localname];
}

- (void)setLastTitleColor:(NSString *)localname globalName:(NSString *)globalname {
    [buttonHelper setTitleColor:lastChangedButton localName:localname globalName:globalname forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname {
    [buttonHelper setTitleColor:button localName:localname globalName:globalname forState:UIControlStateNormal];
}

- (void)setTitleColorForLast:(NSString *)localname globalName:(NSString *)globalname {
    [self setTitleColor:lastChangedButton localName:localname globalName:globalname];
}

- (void)setTitleColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[self setTitleColor:button localName:localname globalName:globalname];
	}
}

- (void)setTitleColorsForLastList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname {
    [self setTitleColorsForList:lastChangedButtonList localName:localname globalName:globalname];
}


- (void)setTitleFont:(UIButton *)button localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
      localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [buttonHelper setTitleFont:button localSizeName:localsizename globalSizeName:globalsizename
                localStyleName:localstylename globalStyleName:globalstylename forState:UIControlStateNormal];
}

- (void)setTitleFontForLast:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [self setTitleFont:lastChangedButton localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setTitleFontsForList:(NSArray *)buttons localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
              localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
	for(UIButton *button in buttons){
		[self setTitleFont:button localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
	}
}

- (void)setTitleFontForLastList:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [self setTitleFontsForList:lastChangedButtonList localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setTitleShadowColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname {
    [buttonHelper setTitleShadowColor:button localName:localname globalName:globalname forState:UIControlStateNormal];
}

- (void)setTitleShadowColorForLast:(NSString *)localname globalName:(NSString *)globalname {
    [self setTitleShadowColor:lastChangedButton localName:localname globalName:globalname];
}

- (void)setTitleShadowColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[self setTitleShadowColor:button localName:localname globalName:globalname];
	}
}

- (void)setTitleShadowColorsForLastList:(NSString *)localname globalName:(NSString *)globalname {
    [self setTitleShadowColorsForList:lastChangedButtonList localName:localname globalName:globalname];
}

- (void)setTitleShadowOffset:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname {
    [buttonHelper setTitleShadowOffset:button localName:localname globalName:globalname forState:UIControlStateNormal];
}

- (void)setTitleShadowOffsetForLast:(NSString *)localname globalName:(NSString *)globalname {
    [self setTitleShadowOffset:lastChangedButton localName:localname globalName:globalname];
}

- (void)setTitleShadowOffsetsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[self setTitleShadowOffset:button localName:localname globalName:globalname];
	}
}

- (void)setTitleShadowOffsetsForLastList:(NSString *)localname globalName:(NSString *)globalname {
    [self setTitleShadowOffsetsForList:lastChangedButtonList localName:localname globalName:globalname];
}

- (void)setCustomStyle:(UIButton *)button tag:(NSString *)tag defaultColor:(NSString *)defColor defaultSize:(NSString *)defSize{

	NSString *localImage = [NSString stringWithFormat:@"%@%@", tag, [RWLOOK APPEARANCEHELPER_DEF_BACKGROUNDIMAGE]];
	NSString *localBackgroundColor = [NSString stringWithFormat:@"%@%@", tag, [RWLOOK APPEARANCEHELPER_DEF_BACKGROUNDCOLOR]];
	NSString *globalBackgroundColor = [NSString stringWithFormat:@"%@%@", defColor, [RWLOOK APPEARANCEHELPER_DEF_COLOR]];
	NSString *localIcon = [NSString stringWithFormat:@"%@%@", tag, [RWLOOK APPEARANCEHELPER_DEF_ICON]];

	NSString *localColor = [NSString stringWithFormat:@"%@%@", tag, [RWLOOK APPEARANCEHELPER_DEF_TEXTCOLOR]];
	NSString *globalColor = [NSString stringWithFormat:@"%@%@",defColor,[RWLOOK APPEARANCEHELPER_DEF_TEXTCOLOR]];
	NSString *localSize = [NSString stringWithFormat:@"%@%@", tag, [RWLOOK APPEARANCEHELPER_DEF_TEXTSIZE]];
	NSString *globalSize = [NSString stringWithFormat:@"%@%@", defSize, [RWLOOK APPEARANCEHELPER_DEF_SIZE]];
	NSString *localStyle = [NSString stringWithFormat:@"%@%@", tag, [RWLOOK APPEARANCEHELPER_DEF_TEXTSTYLE]];
	NSString *globalStyle = [NSString stringWithFormat:@"%@%@", defSize, [RWLOOK APPEARANCEHELPER_DEF_STYLE]];
	NSString *localShadowColor = [NSString stringWithFormat:@"%@%@",tag,[RWLOOK APPEARANCEHELPER_DEF_TEXTSHADOWCOLOR]];
	NSString *globalShadowColor = [NSString stringWithFormat:@"%@%@",defColor,[RWLOOK APPEARANCEHELPER_DEF_TEXTSHADOWCOLOR]];
	NSString *localShadowOffset = [NSString stringWithFormat:@"%@%@", tag, [RWLOOK APPEARANCEHELPER_DEF_TEXTSHADOWOFFSET]];
	NSString *globalShadowOffset = [NSString stringWithFormat:@"%@%@",defSize,[RWLOOK APPEARANCEHELPER_DEF_TEXTSHADOWOFFSET]];
	
	[self setBackgroundImageOrColor:button localImageName:localImage localColorName:localBackgroundColor globalColorName:globalBackgroundColor];
    [self setImageFromLocalSource:button localName:localIcon];
	[self setTitleColor:button localName:localColor globalName:globalColor];
    [self setTitleFont:button localSizeName:localSize globalSizeName:globalSize localStyleName:localStyle globalStyleName:globalStyle];
    [self setTitleShadowColor:button localName:localShadowColor globalName:globalShadowColor];
    [self setTitleShadowOffset:button localName:localShadowOffset globalName:globalShadowOffset];
}

- (void)setButtonStyle:(UIButton *)button{
    [self setBackgroundImageOrColor:button localImageName:[RWLOOK BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
    [self setImageFromLocalSource:button localName:[RWLOOK BUTTONICON]];
    [self setTitleColor:button localName:[RWLOOK BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [self setTitleFont:button localSizeName:[RWLOOK BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [self setTitleShadowColor:button localName:[RWLOOK BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [self setTitleShadowOffset:button localName:[RWLOOK BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

- (void)setBackButtonStyle:(UIButton *)button{
    [self setBackgroundImageOrColor:button localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKBUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
    [self setImageFromLocalSource:button localName:[RWLOOK BACKBUTTONICON]];
    [self setTitleColor:button localName:[RWLOOK BACKBUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [self setTitleFont:button localSizeName:[RWLOOK BACKBUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BACKBUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [self setTitleShadowColor:button localName:[RWLOOK BACKBUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [self setTitleShadowOffset:button localName:[RWLOOK BACKBUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

@end
