//
// Created by Thorbjørn Steen on 9/30/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RWXmlNode;


@interface RWAppearanceHelper : NSObject
- (id)initWithLocalLook:(RWXmlNode *)localLook globalLook:(RWXmlNode *)globalLook;

- (void)setBackgroundColor:(UIView *)view localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setBackgroundTileImageOrColor:(UIView *)view localImageName:(NSString *)localimagename localColorName:(NSString *)localcolorname globalName:(NSString *)globalname;

- (void)setButtonBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName forState:(UIControlState)state;

- (BOOL)setButtonBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state;

- (void)setButtonImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state;

- (void)setButtonTitleColor:(UIButton *)button forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setButtonTitleFont:(UIButton *)button forState:(UIControlState)state localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setButtonTitleShadowColor:(UIButton *)button forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setButtonTitleShadowOffset:(UIButton *)button forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setButtonBackgroundImageOrColors:(NSArray *)buttons localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName forState:(UIControlState)state;

- (void)setButtonImageFromLocalSources:(NSArray *)buttons localName:(NSString *)localname forState:(UIControlState)state;

- (void)setButtonTitleColors:(NSArray *)buttons forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setButtonTitleFonts:(NSArray *)buttons forState:(UIControlState)state localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setButtonTitleShadowColors:(NSArray *)buttons forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setButtonTitleShadowOffsets:(NSArray *)buttons forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLabelColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLabelFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setLabelShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLabelShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLabelColors:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLabelFonts:(NSArray *)labels localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (void)setLabelShadowColors:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLabelShadowOffsets:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLogo:(UIImageView *)imageview imagename:(NSString *)imagename;

-(void)setScrollBounces:(UIScrollView *)scrollView localName:(NSString *)localname globalName:(NSString *)globalname;

- (UIColor *)getColorWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (float)getFloatWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (NSString *)getStringWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (UIFont *)getTextFontWithLocalSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (CGSize)getCGSizeWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (NSValue *)getTextShadowOffsetAsNSValueWithLocalName:(NSString *)localname globalName:(NSString *)globalname;
@end