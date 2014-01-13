//
//  RWLabelAppearanceForwarder.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWAppearanceHelper;
@class RWApperanceHelperGetter;

@interface RWLabelAppearanceForwarder : NSObject

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter;

- (void)setActive:(UILabel *)label;

- (void)setActiveList:(NSArray *)labelList;

- (void)setColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setColorForLast:(NSString *)localname globalName:(NSString *)globalname;

- (void)setColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setColorsForLastList:(NSString *)localname globalName:(NSString *)globalname;

- (void)setFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setFontForLast:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setFontsForList:(NSArray *)labels localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setFontsForLastList:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowColorForLast:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowColorsForLastList:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowOffsetForLast:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowOffsetsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowOffsetsForLastList:(NSString *)localname globalName:(NSString *)globalname;

- (void)setTitleStyle:(UILabel *)label;

- (void)setBackItemTitleStyle:(UILabel *)label;

- (void)setAltItemTitleStyle:(UILabel *)label;

- (void)setBackTextStyle:(UILabel *)label;

- (void)setBackTextStyleForList:(NSArray *)labels;

- (void)setAltTextStyle:(UILabel *)label;

@end
