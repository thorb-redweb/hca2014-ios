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
#import "RWApperanceHelperGetter.h"


@implementation RWAppearanceHelper {
    RWXmlNode *_localLook;
    RWXmlNode *_globalLook;
}

- (id)initWithLocalLook:(RWXmlNode *)localLook globalLook:(RWXmlNode *)globalLook {
    self = [super init];
    if (self) {
        _localLook = localLook;
        _globalLook = globalLook;
		
		_getter = [[RWApperanceHelperGetter alloc] initWithLocalLook:_localLook globalLook:_globalLook];
		
		_button = [[RWButtonAppearanceForwarder alloc] initWithHelper:self Getter:_getter];
		_label = [[RWLabelAppearanceForwarder alloc] initWithHelper:self Getter:_getter];
		_textField = [[RWTextFieldAppearanceForwarder alloc] initWithHelper:self Getter:_getter];
    }
    return self;
}

- (void)setBackgroundColor:(UIView *)view localName:(NSString *)localname globalName:(NSString *)globalname {
    view.backgroundColor = [_getter getColorWithLocalName:localname globalName:globalname];
}

- (void)setBackgroundTileImageOrColor:(UIView *)view localImageName:(NSString *)localimagename localColorName:(NSString *)localcolorname globalName:(NSString *)globalname;
{
	if([_localLook hasChild:localimagename]){
		UIColor *background = [[UIColor alloc] initWithPatternImage:[_getter getImageFromLocalSourceWithLocalName:localimagename]];
		view.backgroundColor = background;
	}
	else{
		[self setBackgroundColor:view localName:localcolorname globalName:globalname];
	}
}

- (void)setBackgroundAsShape:(UIView *)view localBackgroundColorName:(NSString *)localBackgroundColorName globalBackgroundColorName:(NSString *)globalBackgroundColorName borderWidth:(int)borderWidth localBorderColorName:(NSString *)localBorderColorName globalBorderColorName:(NSString *)globalBorderColorName cornerRadius:(int)cornerRadius {
	[self setBackgroundColor:view localName:localBackgroundColorName globalName:globalBackgroundColorName];
	
	[self setBorderColor:view localName:localBorderColorName globalName:globalBorderColorName];
	view.layer.cornerRadius = cornerRadius;
	view.layer.masksToBounds = YES;
	view.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIView *)view localName:(NSString *)localname globalName:(NSString *)globalname{
	view.layer.borderColor = [_getter getColorWithLocalName:localname globalName:globalname].CGColor;
}

- (void)setLogo:(UIImageView *)imageview imagename:(NSString *)imagename{
	UIImage *logo = [UIImage imageNamed:imagename];
	imageview.image = logo;
}

-(void)setScrollBounces:(UIScrollView *)scrollView localName:(NSString *)localname globalName:(NSString *)globalname{
	if([_getter pageOrGlobalHasLocalName:localname globalName:globalname]){
		scrollView.bounces = [_getter getBooleanWithLocalName:localname globalName:globalname];
	}
	else {
		scrollView.bounces = NO;
	}
	
}
@end