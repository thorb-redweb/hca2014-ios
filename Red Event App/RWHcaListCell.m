//
//  RWHcaListCell.m
//  Red App
//
//  Created by Thorbjørn Steen on 2/25/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"
#import "UIImageView+WebCache.h"
#import "RWHcaListCell.h"
#import	"RWSessionVM.h"

@implementation RWHcaListCell{
	RWSessionVM *_sessionObject;
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
}

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource{
	_sessionObject = dataSource[row];
	
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
	NSString *titleString = [NSString stringWithFormat:@"%@: %@", _sessionObject.startTime, _sessionObject.title];
	[_lblTitle setText:titleString];
	[_imgType setImage:_sessionObject.typeIcon];
	[_vwRightBorder setBackgroundColor:_sessionObject.typeColor];
}

- (void)setAppearance{
	RWAppearanceHelper *helper = _appearanceHelper;
	[helper setBackgroundColor:self localName:Nil globalName:[RWLOOK INVISIBLE]];
}


@end
