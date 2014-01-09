//
// Created by Thorbjørn Steen on 9/30/13.
// Copyright (c) 2013 redWEB. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "RWAppearanceHelper.h"
#import "RWXmlNode.h"
#import "UIColor+RWColor.h"
#import "RWLOOK.h"


@implementation RWAppearanceHelper {
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

- (void)setBackgroundColor:(UIView *)view localName:(NSString *)localname globalName:(NSString *)globalname {
    view.backgroundColor = [self getColorWithLocalName:localname globalName:globalname];
}

- (void)setBackgroundTileImageOrColor:(UIView *)view localImageName:(NSString *)localimagename localColorName:(NSString *)localcolorname globalName:(NSString *)globalname;
{
	if([_localLook hasChild:localimagename]){
		UIColor *background = [[UIColor alloc] initWithPatternImage:[self getImageFromLocalSourceWithLocalName:localimagename]];
		view.backgroundColor = background;
	}
	else{
		[self setBackgroundColor:view localName:localcolorname globalName:globalname];
	}
}

- (void)setButtonBackgroundImageOrColor:(UIButton *)button localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName forState:(UIControlState)state{
    if ([_localLook hasChild:localImageName]){
        [button setBackgroundImage:[self getImageFromLocalSourceWithLocalName:localImageName] forState:state];
	}
	else {
		[self setBackgroundColor:button localName:localColorName globalName:globalColorName];
	}
}

- (BOOL)setButtonBackgroundImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state{
    if ([_localLook hasChild:localname]){
        [button setBackgroundImage:[self getImageFromLocalSourceWithLocalName:localname] forState:state];
		return true;
	}
	return false;
}

- (void)setButtonImageFromLocalSource:(UIButton *)button localName:(NSString *)localname forState:(UIControlState)state{
    if ([_localLook hasChild:localname])
        [button setImage:[self getImageFromLocalSourceWithLocalName:localname] forState:state];
}

- (void)setButtonTitleColor:(UIButton *)button forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname {
    [button setTitleColor:[self getColorWithLocalName:localname globalName:globalname] forState:state];
}

- (void)setButtonTitleFont:(UIButton *)button forState:(UIControlState)state localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
                                                                            localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [button.titleLabel setFont:[self getTextFontWithLocalSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename]];
}

- (void)setButtonTitleShadowColor:(UIButton *)button forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname {
    if ([self pageOrGlobalHasLocalName:localname globalName:globalname])
        [button setTitleShadowColor:[self getColorWithLocalName:localname globalName:globalname] forState:state];
}

- (void)setButtonTitleShadowOffset:(UIButton *)button forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname {
    if ([self pageOrGlobalHasLocalName:localname globalName:globalname])
        [button.titleLabel setShadowOffset: [self getCGSizeWithLocalName:localname globalName:globalname]];
}

- (void)setButtonBackgroundImageOrColors:(NSArray *)buttons localImageName:(NSString *)localImageName localColorName:(NSString *)localColorName globalColorName:(NSString *)globalColorName forState:(UIControlState)state{
    for(UIButton *button in buttons){
		[self setBackgroundTileImageOrColor:button localImageName:localImageName localColorName:localColorName globalName:globalColorName];
	}
}

- (void)setButtonImageFromLocalSources:(NSArray *)buttons localName:(NSString *)localname forState:(UIControlState)state{
	for(UIButton *button in buttons){
		[self setButtonImageFromLocalSource:button localName:localname forState:state];
	}
}

- (void)setButtonTitleColors:(NSArray *)buttons forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[self setButtonTitleColor:button forState:state localName:localname globalName:globalname];
	}
}

- (void)setButtonTitleFonts:(NSArray *)buttons forState:(UIControlState)state localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
			localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
	for(UIButton *button in buttons){
		[self setButtonTitleFont:button forState:state localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
	}
}

- (void)setButtonTitleShadowColors:(NSArray *)buttons forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[self setButtonTitleShadowColor:button forState:state localName:localname globalName:globalname];
	}
}

- (void)setButtonTitleShadowOffsets:(NSArray *)buttons forState:(UIControlState)state localName:(NSString *)localname globalName:(NSString *)globalname {
	for(UIButton *button in buttons){
		[self setButtonTitleShadowOffset:button forState:state localName:localname globalName:globalname];
	}
}

- (void)setLabelColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    label.textColor = [self getColorWithLocalName:localname globalName:globalname];
}

- (void)setLabelFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
      localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    label.font = [self getTextFontWithLocalSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setLabelShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    if ([self pageOrGlobalHasLocalName:localname globalName:globalname])
        [label setShadowColor:[self getColorWithLocalName:localname globalName:globalname]];
}

- (void)setLabelShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    if ([self pageOrGlobalHasLocalName:localname globalName:globalname])
        [label setShadowOffset: [self getCGSizeWithLocalName:localname globalName:globalname]];
}

- (void)setLabelColors:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [self setLabelColor:label localName:localname globalName:globalname];
}

- (void)setLabelFonts:(NSArray *)labels localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
      localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    for(UILabel *label in labels)
        [self setLabelFont:label localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setLabelShadowColors:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [self setLabelShadowColor:label localName:localname globalName:globalname];
}

- (void)setLabelShadowOffsets:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [self setLabelShadowOffset:label localName:localname globalName:globalname];
}

- (void)setLogo:(UIImageView *)imageview imagename:(NSString *)imagename{
	UIImage *logo = [UIImage imageNamed:imagename];
	imageview.image = logo;
}

-(void)setScrollBounces:(UIScrollView *)scrollView localName:(NSString *)localname globalName:(NSString *)globalname{
	if([self pageOrGlobalHasLocalName:localname globalName:globalname]){
		scrollView.bounces = [self getBooleanWithLocalName:localname globalName:globalname];
	}
	else {
		scrollView.bounces = NO;
	}
	
}

- (BOOL)getBooleanWithLocalName:(NSString *)localname globalName:(NSString *)globalname{
	if ([_localLook hasChild:localname])
        return [_localLook getBoolFromNode:localname];
    else
        return [_globalLook getBoolFromNode:globalname];
}

- (UIColor *)getColorWithLocalName:(NSString *)localname globalName:(NSString *)globalname {
    if ([_localLook hasChild:localname])
        return [UIColor colorWithHexString:[_localLook getStringFromNode:localname]];
    else if([globalname isEqual:[RWLOOK INVISIBLE]])
		return [UIColor colorWithHexString:@"00000000"];
	else
        return [UIColor colorWithHexString:[_globalLook getStringFromNode:globalname]];
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

- (bool)pageOrGlobalHasLocalName:(NSString *)localname globalName:(NSString *)globalname {
    if ([_localLook hasChild:localname] || [_globalLook hasChild:globalname])
        return true;
    return false;
}
@end