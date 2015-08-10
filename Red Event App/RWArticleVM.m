//
//  RWContent.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"

#import "RWArticleVM.h"

#import "Article.h"
#import "RWXMLStore.h"

@implementation RWArticleVM{
	RWXMLStore *_xml;
	
	NSString *imagesRootPath;
}

- (id)initWithArticle:(Article *)article xml:(RWXMLStore *)xml{
    if (self = [super init]) {
        _content = article;
		_xml = xml;
		imagesRootPath = xml.imagesRootPath;
    }
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"RWArticleVM: \ncontentid: %@ \ntitle: %@ \nalias: %@ \ncatid: %@ \nintrotext: %@ \nfulltext: %@ \nintroImagePath: %@ \nmainImagePath: %@", _content.articleid, _content.title, _content.alias, _content.catid, _content.introtext, _content.fulltext, _content.introimagepath, _content.mainimagepath];
    return description;
}

- (NSNumber *)articleid {
    return _content.articleid;
}

- (NSString *)title {
    return _content.title;
}

- (NSString *)alias {
    return _content.alias;
}

- (NSNumber *)catid {
    return _content.catid;
}

- (NSString *)introtext {
    return _content.introtext;
}

- (NSString *)introtextWithHtml {
//    return [_content.introtext htmlStringWithSystemFont];
	    return [_content.introtext stringByStrippingJoomlaTags];
}

- (NSString *)introtextWithoutHtml {
    return [_content.introtext stringByStrippingHTML];
}

- (NSString *)fulltext {
    return _content.fulltext;
}

- (NSString *)fulltextWithHtml {
//    return [_content.fulltext htmlStringWithSystemFont];
	    return [_content.fulltext stringByStrippingJoomlaTags];
}

- (NSString *)fulltextWithoutHtml {
    return [_content.fulltext stringByStrippingHTML];
}

- (NSString *)introImagePath {
    return _content.introimagepath;
}

- (NSURL *)introImageUrl{
	NSMutableString *urlString = [[NSMutableString alloc] initWithString:imagesRootPath];
    [urlString appendString:[self introImagePath]];
	return [NSURL URLWithString:urlString];
}

- (NSString *)mainImagePath {
    return _content.mainimagepath;
}

- (NSURL *)mainImageUrl{
	NSMutableString *urlString = [[NSMutableString alloc] initWithString:imagesRootPath];
    [urlString appendString:[self mainImagePath]];
	return [NSURL URLWithString:urlString];
}

- (NSURL *)imageUrl{
	NSMutableString *urlString = [[NSMutableString alloc] initWithString:imagesRootPath];
    [urlString appendString:[self introImagePath]];
	return [NSURL URLWithString:urlString];
}

- (NSString *)datePublished {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd. MMMM yyyy"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"da"]];
    return [dateFormatter stringFromDate:_content.publishdate];
}

@end
