//
//  RWTextHelper.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/8/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWTextHelper.h"

#import "RWXMLStore.h"
#import "RWXmlNode.h"


@implementation RWTextHelper{
	RWXmlNode *textStore;
}

-(id)initWithPageName:(NSString *)pagename xmlStore:(RWXMLStore *)xmlStore{
	if(self = [super init]){
		textStore = [xmlStore getTextForPage:pagename];
	}
	return self;
}

-(void)setText:(UILabel *)label textName:(NSString *)textName defaultText:(NSString *)defaultText{
	NSString *text;
	if([textStore hasChild:textName]){
		text = [textStore getStringFromNode:textName];
	} else {
		text = defaultText;
	}
	
	[label setText:text];
}

-(void)setButtonText:(UIButton *)button textName:(NSString *)textName defaultText:(NSString *)defaultText{
	NSString *text;
	if([textStore hasChild:textName]){
		text = [textStore getStringFromNode:textName];
	} else {
		text = defaultText;
	}
	
	[button setTitle:text forState:UIControlStateNormal];
}

-(void)setTextFieldPlaceHolderText:(UITextField *)textField textName:(NSString *)textName defaultText:(NSString *)defaultText{
	NSString *text;
	if([textStore hasChild:textName]){
		text = [textStore getStringFromNode:textName];
	} else {
		text = defaultText;
	}
	
	[textField setPlaceholder:text];
}

-(void)tryText:(UILabel *)label textName:(NSString *)textName{
	if([textStore hasChild:textName]){
		[self setText:label textName:textName defaultText:@""];
	}
}

@end
