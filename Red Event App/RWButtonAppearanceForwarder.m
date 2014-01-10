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

@implementation RWButtonAppearanceForwarder{
	RWApperanceHelperGetter *getter;
	RWButtonAppearanceHelper *buttonHelper;
}

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter{
	if(self = [super init]){
		buttonHelper = [[RWButtonAppearanceHelper alloc] initWithHelper:apperanceHelper Getter:appearanceGetter];
		getter = appearanceGetter;
	}
	return self;
}

- (void)setBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName{
    [buttonHelper setBackgroundImageOrColor:button localImageName:localImageName localColorName:localColorName globalColorName:globalColorName forState:UIControlStateNormal];
}

- (BOOL)setBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname{
    return [buttonHelper setBackgroundImageFromLocalSource:button localName:localname forState:UIControlStateNormal];
}

- (void)setImageFromLocalSource:(UIButton *)button localName:(NSString *)localname{
    [buttonHelper setImageFromLocalSource:button localName:localname forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname {
    [buttonHelper setTitleColor:button localName:localname globalName:globalname forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIButton *)button localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
      localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [buttonHelper setTitleFont:button localSizeName:localsizename globalSizeName:globalsizename
                localStyleName:localstylename globalStyleName:globalstylename forState:UIControlStateNormal];
}

- (void)setTitleShadowColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname {
    [buttonHelper setTitleShadowColor:button localName:localname globalName:globalname forState:UIControlStateNormal];
}

- (void)setTitleShadowOffset:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname {
    [buttonHelper setTitleShadowOffset:button localName:localname globalName:globalname forState:UIControlStateNormal];
}

- (void)setBackgroundImageOrColorsForList:(NSArray *)buttons localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName {
    for(UIButton *button in buttons){
		[buttonHelper setBackgroundImageOrColor:button localImageName:localImageName localColorName:localColorName globalColorName:globalColorName forState:UIControlStateNormal];
	}
}

- (void)setImageFromLocalSourcesForList:(NSArray *)buttons localName:(NSString *)localname {
	for(UIButton *button in buttons){
		[buttonHelper setImageFromLocalSource:button localName:localname forState:UIControlStateNormal];
	}
}

- (void)setTitleColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[buttonHelper setTitleColor:button localName:localname globalName:globalname forState:UIControlStateNormal];
	}
}

- (void)setTitleFontsForList:(NSArray *)buttons localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
              localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
	for(UIButton *button in buttons){
		[buttonHelper setTitleFont:button localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename forState:UIControlStateNormal];
	}
}

- (void)setTitleShadowColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[buttonHelper setTitleShadowColor:button localName:localname globalName:globalname forState:UIControlStateNormal];
	}
}

- (void)setTitleShadowOffsetsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[buttonHelper setTitleShadowOffset:button localName:localname globalName:globalname forState:UIControlStateNormal];
	}
}

@end
