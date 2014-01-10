//
//  RWApperanceHelperGetter.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RWXmlNode;

@interface RWApperanceHelperGetter : NSObject

- (id)initWithLocalLook:(RWXmlNode *)localLook globalLook:(RWXmlNode *)globalLook;

- (BOOL)getBooleanWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (UIColor *)getColorWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (float)getFloatWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (UIImage *)getImageFromLocalSourceWithLocalName:(NSString *)localname;

- (NSString *)getStringWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (UIFont *)getTextFontWithLocalSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
                          localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename;

- (CGSize)getCGSizeWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (NSValue *)getTextShadowOffsetAsNSValueWithLocalName:(NSString *)localname globalName:(NSString *)globalname;

- (bool)pageHasLocalName:(NSString *)localname;

- (bool)pageOrGlobalHasLocalName:(NSString *)localname globalName:(NSString *)globalname;

//Not used currently. Demo outcommented in ArticleDetailViewController:setAppearance
-(UIMotionEffectGroup *)getTopMotionEffectGroup;

//Not used currently. Demo outcommented in ArticleDetailViewController:setAppearance
-(UIMotionEffectGroup *)getBottomMotionEffectGroup;

@end
