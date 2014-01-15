//
//  RWTextFieldAppearanceHelper.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/15/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWTextFieldAppearanceHelper.h"

#import "RWAppearanceHelper.h"
#import "RWApperanceHelperGetter.h"

@implementation RWTextFieldAppearanceHelper{
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

- (void)setColor:(UITextField *)textField localName:(NSString *)localname globalName:(NSString *)globalname {
    textField.textColor = [getter getColorWithLocalName:localname globalName:globalname];
}

- (void)setFont:(UITextField *)textField localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
 localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    textField.font = [getter getTextFontWithLocalSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setPlaceHolderTextStyle:(UITextField *)textField placeholderText:(NSString *)placeholderText localColorName:(NSString *)localcolorname globalColorName:(NSString *)globalcolorname
 localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename{
    UIColor *color = [getter getColorWithLocalName:localcolorname globalName:globalcolorname];
	UIFont *font = [getter getTextFontWithLocalSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
	textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: font}];
}

@end
