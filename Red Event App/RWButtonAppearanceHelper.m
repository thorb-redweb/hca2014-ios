//
//  RWButtonAppearanceHelper.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWButtonAppearanceHelper.h"

#import "RWAppearanceHelper.h"
#import "RWApperanceHelperGetter.h"

@implementation RWButtonAppearanceHelper{
	RWAppearanceHelper *helper;
	RWApperanceHelperGetter *getter;
}


- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter{
	if(self = [super init]){
		helper = apperanceHelper;
		getter = appearanceGetter;
	}
	return self;
}

- (void)setBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName forState:(UIControlState)state{
    if ([getter pageHasLocalName:localImageName]){
        [button setBackgroundImage:[getter getImageFromLocalSourceWithLocalName:localImageName] forState:state];
	}
	else {
		[helper setBackgroundColor:button localName:localColorName globalName:globalColorName];
	}
}

- (BOOL)setBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state{
    if ([getter pageHasLocalName:localname]){
        [button setBackgroundImage:[getter getImageFromLocalSourceWithLocalName:localname] forState:state];
		return true;
	}
	return false;
}

- (void)setImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state{
    if ([getter pageHasLocalName:localname])
        [button setImage:[getter getImageFromLocalSourceWithLocalName:localname] forState:state];
}

- (void)setTitleColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname forState:(UIControlState)state {
    [button setTitleColor:[getter getColorWithLocalName:localname globalName:globalname] forState:state];
}

- (void)setTitleFont:(UIButton *)button localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
      localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename forState:(UIControlState)state {
    [button.titleLabel setFont:[getter getTextFontWithLocalSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename]];
}

- (void)setTitleShadowColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname forState:(UIControlState)state {
    if ([getter pageOrGlobalHasLocalName:localname globalName:globalname])
        [button setTitleShadowColor:[getter getColorWithLocalName:localname globalName:globalname] forState:state];
}

- (void)setTitleShadowOffset:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname forState:(UIControlState)state {
    if ([getter pageOrGlobalHasLocalName:localname globalName:globalname])
        [button.titleLabel setShadowOffset: [getter getCGSizeWithLocalName:localname globalName:globalname]];
}

@end
