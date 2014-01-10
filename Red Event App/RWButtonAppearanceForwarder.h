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

- (void)setBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName;

- (BOOL)setBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname;

- (void)setImageFromLocalSource:(UIButton *)button localName:(NSString *)localname;

- (void)setTitleColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleFont:(UIButton *)button localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setTitleShadowColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowOffset:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setBackgroundImageOrColorsForList:(NSArray *)buttons localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName;

- (void)setImageFromLocalSourcesForList:(NSArray *)buttons localName:(NSString *)localname;

- (void)setTitleColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleFontsForList:(NSArray *)buttons localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setTitleShadowColorsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleShadowOffsetsForList:(NSArray *)buttons localName:(NSString *)localname globalName:(NSString *)globalname;

@end
