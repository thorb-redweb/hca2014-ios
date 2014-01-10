//
//  RWLabelAppearanceHelper.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWLabelAppearanceHelper.h"

#import "RWAppearanceHelper.h"
#import "RWApperanceHelperGetter.h"

@implementation RWLabelAppearanceHelper{
	RWAppearanceHelper *helper;
	RWApperanceHelperGetter *getter;
}

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter{
	if(self = [super init]){
		helper = apperanceHelper;
		getter = appearanceGetter;
	}
	return self;
}

- (void)setColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    label.textColor = [getter getColorWithLocalName:localname globalName:globalname];
}

- (void)setFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
      localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    label.font = [getter getTextFontWithLocalSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    if ([getter pageOrGlobalHasLocalName:localname globalName:globalname])
        [label setShadowColor:[getter getColorWithLocalName:localname globalName:globalname]];
}

- (void)setShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    if ([getter pageOrGlobalHasLocalName:localname globalName:globalname])
        [label setShadowOffset: [getter getCGSizeWithLocalName:localname globalName:globalname]];
}

@end
