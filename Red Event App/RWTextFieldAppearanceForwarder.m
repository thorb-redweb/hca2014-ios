//
//  RWTextFieldAppearanceForwarder.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/15/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWTextFieldAppearanceForwarder.h"

#import "RWTextFieldAppearanceHelper.h"

#import "RWLOOK.h"

@implementation RWTextFieldAppearanceForwarder{
	RWApperanceHelperGetter *getter;
	RWTextFieldAppearanceHelper *textFieldHelper;
}

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter{
	if(self = [super init]){
		textFieldHelper = [[RWTextFieldAppearanceHelper alloc] initWithHelper:apperanceHelper Getter:appearanceGetter];
		getter = appearanceGetter;
	}
	return self;
}

- (void)setColor:(UITextField *)textField localName:(NSString *)localname globalName:(NSString *)globalname{
	[textFieldHelper setColor:textField localName:localname globalName:globalname];
}

- (void)setFont:(UITextField *)textField localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
	  localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename{
	[textFieldHelper setFont:textField localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setPlaceHolderTextStyle:(UITextField *)textField placeholderText:(NSString *)placeholderText localColorName:(NSString *)localcolorname globalColorName:(NSString *)globalcolorname
			  localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename{
	[textFieldHelper setPlaceHolderTextStyle:textField placeholderText:placeholderText localColorName:localcolorname globalColorName:globalcolorname localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setTextFieldStyle:(UITextField *)textField{
	[self setColor:textField localName:[RWLOOK TEXTFIELDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[self setFont:textField localSizeName:[RWLOOK TEXTFIELDSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE] localStyleName:[RWLOOK TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
}

@end
