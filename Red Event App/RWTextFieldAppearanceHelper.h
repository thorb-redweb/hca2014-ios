//
//  RWTextFieldAppearanceHelper.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/15/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWAppearanceHelper;
@class RWApperanceHelperGetter;

@interface RWTextFieldAppearanceHelper : NSObject

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter;

- (void)setColor:(UITextField *)textField localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setFont:(UITextField *)textField localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
	  localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setPlaceHolderTextStyle:(UITextField *)textField placeholderText:(NSString *)placeholderText localColorName:(NSString *)localcolorname globalColorName:(NSString *)globalcolorname
			  localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

@end
