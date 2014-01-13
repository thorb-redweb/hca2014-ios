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
#import "RWLOOK.h"


@implementation RWLabelAppearanceForwarder{
	RWApperanceHelperGetter *getter;
	RWLabelAppearanceHelper *labelHelper;

    UILabel *lastChangedLabel;
    NSArray *lastChangedLabelList;
}

- (id)initWithHelper:(RWAppearanceHelper *)apperanceHelper Getter:(RWApperanceHelperGetter *)appearanceGetter{
	if(self = [super init]){
		labelHelper = [[RWLabelAppearanceHelper alloc] initWithHelper:apperanceHelper Getter:appearanceGetter];
		getter = appearanceGetter;
	}
	return self;
}

- (void)setActive:(UILabel *)label{
    lastChangedLabel = label;
}

- (void)setActiveList:(NSArray *)labelList{
    lastChangedLabelList = labelList;
}

- (void)setColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    [labelHelper setColor:label localName:localname globalName:globalname];
}

- (void)setColorForLast:(NSString *)localname globalName:(NSString *)globalname {
    [self setColor:lastChangedLabel localName:localname globalName:globalname];
}

- (void)setColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels){
        [self setColor:label localName:localname globalName:globalname];
    }
}

- (void)setColorsForLastList:(NSString *)localname globalName:(NSString *)globalname {
    [self setColorsForList:lastChangedLabelList localName:localname globalName:globalname];
}

- (void)setFont:(UILabel *)label localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
 localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [labelHelper setFont:label localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setFontForLast:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [self setFont:lastChangedLabel localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setFontsForList:(NSArray *)labels localSizeName:(NSString *)localsizename globalSizeName:(NSString *)globalsizename
         localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    for(UILabel *label in labels)
        [self setFont:label localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setFontsForLastList:(NSString *)localsizename globalSizeName:(NSString *)globalsizename localStyleName:(NSString *)localstylename globalStyleName:(NSString *)globalstylename {
    [self setFontsForList:lastChangedLabelList localSizeName:localsizename globalSizeName:globalsizename localStyleName:localstylename globalStyleName:globalstylename];
}

- (void)setShadowColor:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    [labelHelper setShadowColor:label localName:localname globalName:globalname];
}

- (void)setShadowColorForLast:(NSString *)localname globalName:(NSString *)globalname {
    [self setShadowColor:lastChangedLabel localName:localname globalName:globalname];
}

- (void)setShadowColorsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [self setShadowColor:label localName:localname globalName:globalname];
}

- (void)setShadowColorsForLastList:(NSString *)localname globalName:(NSString *)globalname {
    [self setShadowColorsForList:lastChangedLabelList localName:localname globalName:globalname];
}

- (void)setShadowOffset:(UILabel *)label localName:(NSString *)localname globalName:(NSString *)globalname {
    [labelHelper setShadowOffset:label localName:localname globalName:globalname];
}

- (void)setShadowOffsetForLast:(NSString *)localname globalName:(NSString *)globalname {
    [self setShadowOffset:lastChangedLabel localName:localname globalName:globalname];
}

- (void)setShadowOffsetsForList:(NSArray *)labels localName:(NSString *)localname globalName:(NSString *)globalname {
    for(UILabel *label in labels)
        [self setShadowOffset:label localName:localname globalName:globalname];
}

- (void)setShadowOffsetsForLastList:(NSString *)localname globalName:(NSString *)globalname {
    [self setShadowOffsetsForList:lastChangedLabelList localName:localname globalName:globalname];
}

- (void)setTitleStyle:(UILabel *)label{
    [self setColor:label localName:[RWLOOK TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [self setFont:label localSizeName:[RWLOOK TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE] localStyleName:[RWLOOK TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
    [self setShadowColor:label localName:[RWLOOK TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [self setShadowOffset:label localName:[RWLOOK TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];
}

- (void)setBackItemTitleStyle:(UILabel *)label{
    [self setColor:label localName:[RWLOOK ITEMTITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [self setFont:label localSizeName:[RWLOOK ITEMTITLESIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK ITEMTITLESTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [self setShadowColor:label localName:[RWLOOK ITEMTITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [self setShadowOffset:label localName:[RWLOOK ITEMTITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

- (void)setAltItemTitleStyle:(UILabel *)label{
    [self setColor:label localName:[RWLOOK ITEMTITLECOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [self setFont:label localSizeName:[RWLOOK ITEMTITLESIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK ITEMTITLESTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [self setShadowColor:label localName:[RWLOOK ITEMTITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [self setShadowOffset:label localName:[RWLOOK ITEMTITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

- (void)setBackTextStyle:(UILabel *)label{
    [self setColor:label localName:[RWLOOK TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [self setFont:label localSizeName:[RWLOOK TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE] localStyleName:[RWLOOK TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [self setShadowColor:label localName:[RWLOOK TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [self setShadowOffset:label localName:[RWLOOK TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}

- (void)setBackTextStyleForList:(NSArray *)labels{
    for(UILabel *label in labels){
        [self setBackTextStyle:label];
    }
}

- (void)setAltTextStyle:(UILabel *)label{
    [self setColor:label localName:[RWLOOK TEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [self setFont:label localSizeName:[RWLOOK TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE] localStyleName:[RWLOOK TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [self setShadowColor:label localName:[RWLOOK TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [self setShadowOffset:label localName:[RWLOOK TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}

@end
