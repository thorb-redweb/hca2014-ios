//
//  RWNewstickerCell.m
//  Red App
//
//  Created by Thorbjørn Steen on 2/25/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "RWNewstickerCell.h"

@implementation RWNewstickerCell

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if(self){
		[[NSBundle mainBundle] loadNibNamed:@"RWNewstickerCell" owner:self options:nil];
		[self addSubview:self.view];
	}
	return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
	
	[[NSBundle mainBundle] loadNibNamed:@"RWNewstickerCell" owner:self options:nil];
    [self addSubview:self.view];
}


@end
