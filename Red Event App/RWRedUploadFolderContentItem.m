//
//  RWRedUploadFolderContentItem.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/20/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWRedUploadFolderContentItem.h"

#import "RedUploadImage.h"

@implementation RWRedUploadFolderContentItem{
	RedUploadImage *_redUploadImageObject;
	UIImage *_thumbnail;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupCellWithRow:(int)row dataSource:(NSArray *)dataSource thumbnail:(UIImage *)thumbnail{
	_redUploadImageObject = dataSource[row];
	_thumbnail = thumbnail;
	
	[self setControls];
	[self setAppearance];
	[self setCellContents];
}

- (void)setControls{
	_lblText.preferredMaxLayoutWidth = 150 - 10 - 16;
}

- (void)setAppearance{
	RWAppearanceHelper *helper = _appearanceHelper;
	[helper setBackgroundColor:self localName:nil globalName:[RWLOOK INVISIBLE]];
}

- (void)setCellContents{
    [_imgPicture setImage:_thumbnail];
	[_lblText setText:_redUploadImageObject.text];
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
