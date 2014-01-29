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

- (void)setBackgroundAsShape:(UIView *)view localBackgroundColorName:(NSString *)localBackgroundColorName globalBackgroundColorName:(NSString *)globalBackgroundColorName borderWidth:(int)borderWidth localBorderColorName:(NSString *)localBorderColorName globalBorderColorName:(NSString *)globalBorderColorName cornerRadius:(int)cornerRadius;

- (void)setBackgroundsAsShape:(NSArray *)views localBackgroundColorName:(NSString *)localBackgroundColorName globalBackgroundColorName:(NSString *)globalBackgroundColorName borderWidth:(int)borderWidth localBorderColorName:(NSString *)localBorderColorName globalBorderColorName:(NSString *)globalBorderColorName cornerRadius:(int)cornerRadius;

- (void)setBackgroundAsShapeWithGradiant:(UIView *)view localBackgroundColorName1:(NSString *)localBackgroundColorName1 globalBackgroundColorName1:(NSString *)globalBackgroundColorName1
			   localBackgroundColorName2:(NSString *)localBackgroundColorName2 globalBackgroundColorName2:(NSString *)globalBackgroundColorName2
							 borderWidth:(int)borderWidth localBorderColorName:(NSString *)localBorderColorName globalBorderColorName:(NSString *)globalBorderColorName cornerRadius:(int)cornerRadius;

- (void)setBorderColor:(UIView *)view localName:(NSString *)localname globalName:(NSString *)globalname;

- (void)setLogo:(UIImageView *)imageview imagename:(NSString *)imagename;

-(void)setScrollBounces:(UIScrollView *)scrollView localName:(NSString *)localname globalName:(NSString *)globalname;
@end