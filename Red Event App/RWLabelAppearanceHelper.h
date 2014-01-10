//
//  RWLabelAppearanceHelper.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWAppearanceHelper;
@class RWApperanceHelperGetter;

@interface RWLabelAppearanceHelper : NSObject

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter;

- (void)setColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

@end
