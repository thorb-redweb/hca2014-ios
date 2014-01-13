//
//  RWButtonAppearanceForwarder.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWAppearanceHelper;
@class RWApperanceHelperGetter;

@interface RWButtonAppearanceForwarder : NSObject

-  (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper  Getter:(RWApperanceHelperGetter *)appearanceGetter;

- (void)setActive:(UIButton *)button;

- (void)setActiveList:(NSArray *)buttonList;

- (void)setBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName;

- (void)setBackgroundImageOrColorForLast:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName;

- (void)setBackgroundImageOrColorsForList:(NSArray *)buttons localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName;

- (void)setBackgroundImageOrColorsForLastList:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName;

- (BOOL)setBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname;

- (BOOL)setBackgroundImageFromLocalSourceForLast:(NSString *)localname;

- (void)setImageFromLocalSource:(UIButton *)button localName:(NSString *)localname;

- (void)setImageFromLocalSourceForLast:(NSString *)localname;

- (void)setImageFromLocalSourcesForList:(NSArray *)buttons localName:(NSString *)localname;

- (void)setImageFromLocalSourcesForLastList:(NSString *)localname;

- (void)setTitleColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleColorForLast:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleColorsForLastList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleFont:(UIButton *)button localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setTitleFontForLast:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setTitleFontsForList:(NSArray *)buttons localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setTitleFontForLastList:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setTitleShadowColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowColorForLast:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowColorsForLastList:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowOffset:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowOffsetForLast:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowOffsetsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowOffsetsForLastList:(NSString *)localname globalName:(NSString *)globalname;

- (void)setButtonStyle:(UIButton *)button;

- (void)setBackButtonStyle:(UIButton *)button;

@end
