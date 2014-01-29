//
//  RWApperanceHelperGetter.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "UIColor+RWColor.h"

#import "RWApperanceHelperGetter.h"

#import "RWLOOK.h"
#import "RWXmlNode.h"

@implementation RWApperanceHelperGetter {
    RWXmlNode *_localLook;
    RWXmlNode *_globalLook;
}

- (id)initWithLocalLook:(RWXmlNode *)localLook globalLook:(RWXmlNode *)globalLook {
    self = [super init];
    if (self) {
        _localLook = localLook;
        _globalLook = globalLook;
    }
    return self;
}

- (BOOL)getBooleanWithLocalName:(NSString *)localname globalName:(NSString *)globalname{
	if ([_localLook hasChild:localname])
        return [_localLook getBoolFromNode:localname];
    else
        return [_globalLook getBoolFromNode:globalname];
}

- (UIColor *)getColorWithLocalName:(NSString *)localname globalName:(NSString *)globalname {
	if([self staticColors:globalname]){
		return [UIColor colorWithHexString:[self staticColors:globalname]];
	}
	
    if ([_localLook hasChild:localname]) {
		return [self getColorWithName: [_localLook getStringFromNode:localname]];
	}
	else {
		return [self getColorWithName: [_globalLook getStringFromNode:globalname]];
	}
}

- (UIColor *)getColorWithName:(NSString *)name{
	if([self staticColors:name]){
		return [UIColor colorWithHexString:[self staticColors:name]];
	}
	
	return [UIColor colorWithHexString:name];
}

- (NSString *)staticColors:(NSString *)hexString{
	if([hexString isEqualToString:[RWLOOK BLACK]]){
		return @"#000000";
	}
	else if([hexString isEqualToString:[RWLOOK DARKGREY]]){
		return @"#666666";
	}
	else if([hexString isEqualToString:[RWLOOK INVISIBLE]]){
		return @"#00000000";
	}
	else if([hexString isEqualToString:[RWLOOK WHITE]]){
		return @"#FFFFFF";
	}
	return nil;
}

- (float)getFloatWithLocalName:(NSString *)localname globalName:(NSString *)globalname {
    if ([_localLook hasChild:localname])
        return [_localLook getFloatFromNode:localname];
    else
        return [_globalLook getFloatFromNode:globalname];
}

- (UIImage *)getImageFromLocalSourceWithLocalName:(NSString *)localname{
    return [UIImage imageNamed:[_localLook getStringFromNode:localname]];
}

- (NSString *)getStringWithLocalName:(NSString *)localname globalName:(NSString *)globalname {
    if ([_localLook hasChild:localname])
        return [_localLook getStringFromNode:localname];
    else
        return [_globalLook getStringFromNode:globalname];
}

- (UIFont *)getTextFontWithLocalSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
                          localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    float textSize = [self getFloatWithLocalName:localsizename globalName:globalsizename];
    NSString *textStyle = [self getStringWithLocalName:localstylename globalName:globalstylename];
	
    UIFont *textFont = [UIFont systemFontOfSize:textSize];
    if ([textStyle isEqual:[RWLOOK TYPEFACE_BOLD]])
        textFont = [UIFont boldSystemFontOfSize:textSize];
    else if ([textStyle isEqual:[RWLOOK TYPEFACE_BOLD_ITALIC]])
        textFont = [UIFont fontWithName:@"Helvetica-BoldOblique" size:textSize];
    else if ([textStyle isEqual:[RWLOOK TYPEFACE_ITALIC]])
        textFont = [UIFont italicSystemFontOfSize:textSize];
    return textFont;
}

- (CGSize)getCGSizeWithLocalName:(NSString *)localname globalName:(NSString *)globalname {
	
    NSString *sizeAsString;
    if ([_localLook hasChild:localname])
        sizeAsString = [_localLook getStringFromNode:localname];
    else
        sizeAsString = [_globalLook getStringFromNode:globalname];
	
    NSArray *offsets = [sizeAsString componentsSeparatedByString:@","];
    return CGSizeMake([offsets[0] floatValue], [offsets[1] floatValue]);
}

- (NSValue *)getTextShadowOffsetAsNSValueWithLocalName:(NSString *)localname globalName:(NSString *)globalname {
	
    NSString *offsetAsString;
    if ([_localLook hasChild:localname])
        offsetAsString = [_localLook getStringFromNode:localname];
    else if ([_globalLook hasChild:globalname])
        offsetAsString = [_globalLook getStringFromNode:globalname];
    else
        return nil;
	
    NSArray *offsets = [offsetAsString componentsSeparatedByString:@","];
    return [NSValue valueWithUIOffset:UIOffsetMake([offsets[0] floatValue], [offsets[1] floatValue])];
}

//Not used currently. Demo outcommented in ArticleDetailViewController:setAppearance
-(UIMotionEffectGroup *)getTopMotionEffectGroup{
	UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	xAxis.minimumRelativeValue = @-40;
	xAxis.maximumRelativeValue = @40;
	UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	yAxis.minimumRelativeValue = @-40;
	yAxis.maximumRelativeValue = @40;
	
	UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
	group.motionEffects = @[xAxis, yAxis];
	return group;
}

//Not used currently. Demo outcommented in ArticleDetailViewController:setAppearance
-(UIMotionEffectGroup *)getBottomMotionEffectGroup{
	UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	xAxis.minimumRelativeValue = @40;
	xAxis.maximumRelativeValue = @-40;
	UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	yAxis.minimumRelativeValue = @40;
	yAxis.maximumRelativeValue = @-40;
	
	UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
	group.motionEffects = @[xAxis, yAxis];
	return group;
}

- (bool)pageHasLocalName:(NSString *)localname{
	if ([_localLook hasChild:localname])
        return true;
    return false;
}

- (bool)pageOrGlobalHasLocalName:(NSString *)localname globalName:(NSString *)globalname {
    if ([_localLook hasChild:localname] || [_globalLook hasChild:globalname])
        return true;
    return false;
}

@end
