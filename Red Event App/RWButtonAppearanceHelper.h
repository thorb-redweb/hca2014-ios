//
//  RWButtonAppearanceHelper.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWAppearanceHelper;
@class RWApperanceHelperGetter;

@interface RWButtonAppearanceHelper : NSObject

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter;

- (void)setBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName forState:(UIControlState)state;

- (BOOL)setBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state;

- (void)setImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state;

- (void)setTitleColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname forState:(UIControlState)state;

- (void)setTitleFont:(UIButton *)button localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename forState:(UIControlState)state;

- (void)setTitleShadowColor:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname forState:(UIControlState)state;

- (void)setTitleShadowOffset:(UIButton *)button localName:(NSString *)localname globalName:(NSString *)globalname forState:(UIControlState)state;

@end
