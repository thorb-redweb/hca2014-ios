//
// Created by Thorbjørn Steen on 9/30/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "RWApperanceHelperGetter.h"
#import "RWButtonAppearanceForwarder.h"
#import "RWLabelAppearanceForwarder.h"
#import "RWTextFieldAppearanceForwarder.h"

@class RWXmlNode;

@interface RWAppearanceHelper : NSObject

@property (strong, nonatomic) RWApperanceHelperGetter *getter;
@property (strong, nonatomic) RWButtonAppearanceForwarder *button;
@property (strong, nonatomic) RWLabelAppearanceForwarder *label;
@property (strong, nonatomic) RWTextFieldAppearanceForwarder *textField;

- (id)initWithLocalLook:(RWXmlNode *)localLook globalLook:(RWXmlNode *)globalLook;

- (void)setBackgroundColor:(UIView *)view localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setBackgroundTileImageOrColor:(UIView *)view localImageName:(NSString *)localimagename localColorName:(NSString *)localcolorname globalName:(NSString *)globalname;

- (void)setBorderColor:(UIView *)view localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLogo:(UIImageView *)imageview imagename:(NSString *)imagename;

-(void)setScrollBounces:(UIScrollView *)scrollView localName:(NSString *)localname globalName:(NSString *)globalname;
@end