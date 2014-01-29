//
//  RWRedUploadFolderContentItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadFolderContentItem.h"


@implementation RWRedUploadFolderContentItem{
	UIImage *_thumbnail;
	bool selected;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initializeCellWithParentPage:(RWXmlNode *)page{
	[super initializeCellWithParentPage:page];
	
	if([_page hasChild:@"selected"] && [_page getBoolFromNode:@"selected"]){
		selected = true;
	}
	else{
		selected = false;
	}
}

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource thumbnail:(UIImage *)thumbnail{
	_redUploadImageObject = dataSource[row];
	_thumbnail = thumbnail;
	
	[self setValues];
	[self setControls];
	[self setCellContents];
	[self setAppearance];
}

- (void)setValues{

}

- (void)setControls{

}

- (void)setCellContents{
    [_imgPicture setImage:_thumbnail];
	[_lblText setText:_redUploadImageObject.text];
}

- (void)setAppearance{
	RWAppearanceHelper *helper = _appearanceHelper;
	[helper setBackgroundColor:self localName:Nil globalName:[RWLOOK INVISIBLE]];
	
	if(selected){
		[self setSelected];
	}
	else {
		[self setDeSelected];
	}
	
	if(_redUploadImageObject.approved){
		[helper setBackgroundColor:_vwApprovedTag localName:@"approveditemmarkercolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	}
	else {
		[helper setBackgroundColor:_vwApprovedTag localName:@"unapproveditemmarkercolor" globalName:[RWLOOK DEFAULT_BARCOLOR]];
	}
}

- (void) setSelected{
	selected = true;
	
	RWAppearanceHelper *helper = _appearanceHelper;
	[helper setBackgroundColor:_vwTopArea localName:@"selecteditembackgroundcolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	
	[helper setBackgroundAsShape:_vwBottomArea localBackgroundColorName:@"selecteditembackgroundcolor" globalBackgroundColorName:[RWLOOK DEFAULT_ALTCOLOR] borderWidth:1 localBorderColorName:@"itembordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	[helper.label setColor:_lblText localName:@"selecteditemtextcolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	
}

- (void) setDeSelected{
	selected = false;
	
	RWAppearanceHelper *helper = _appearanceHelper;
	[helper setBackgroundColor:_vwTopArea localName:@"imagebackgroundcolor" globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper setBackgroundAsShape:_vwBottomArea localBackgroundColorName:@"itembackgroundcolor" globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:1 localBorderColorName:@"itembordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	[helper.label setColor:_lblText localName:@"selecteditemtextcolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	
	[helper.label setBackItemTitleStyle:_lblText];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
