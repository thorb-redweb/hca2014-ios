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

- (void)setColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setFontsForList:(NSArray *)labels localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setShadowColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowOffsetsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

@end
