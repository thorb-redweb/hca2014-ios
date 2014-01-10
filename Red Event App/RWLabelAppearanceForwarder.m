//
//  RWLabelAppearanceForwarder.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/10/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWLabelAppearanceForwarder.h"

#import "RWLabelAppearanceHelper.h"
#import "RWApperanceHelperGetter.h"


@implementation RWLabelAppearanceForwarder{
	RWApperanceHelperGetter *getter;
	RWLabelAppearanceHelper *labelHelper;
}

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter{
	if(self = [super init]){
		labelHelper = [[RWLabelAppearanceHelper alloc] initWithHelper:apperanceHelper Getter:appearanceGetter];
		getter = appearanceGetter;
	}
	return self;
}

- (void)setColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    [labelHelper setColor:label localName:localname globalName:globalname];
}

- (void)setFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
 localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [labelHelper setFont:label localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    [labelHelper setShadowColor:label localName:localname globalName:globalname];
}

- (void)setShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    [labelHelper setShadowOffset:label localName:localname globalName:globalname];
}

- (void)setColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [labelHelper setColor:label localName:localname globalName:globalname];
}

- (void)setFontsForList:(NSArray *)labels localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
         localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    for(UILabel *label in labels)
        [labelHelper setFont:label localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setShadowColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [labelHelper setShadowColor:label localName:localname globalName:globalname];
}

- (void)setShadowOffsetsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [labelHelper setShadowOffset:label localName:localname globalName:globalname];
}

@end
