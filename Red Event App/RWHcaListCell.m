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
//	_thumbnail = thumbnail;
	
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
	NSURL *imagePath = _sessionObject.imageUrl;
	[_imgArticle setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]
					completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
						float imageHeight = image.size.height;
						float imageWidth = image.size.width;
						if(imageHeight == 0 || imageWidth == 0){
							[_imgArticle RWsetHeightAsConstraint:40];
							[_imgArticle RWsetWidthAsConstraint:40];
						}
						else if(imageHeight > imageWidth){
							[_imgArticle RWsetHeightAsConstraint:40];
							float aspectWidth = imageWidth * 40 / imageHeight;
							[_imgArticle RWsetHeightAsConstraint:aspectWidth];
						}
						else{
							[_imgArticle RWsetWidthAsConstraint:40];
							float aspectHeight = imageHeight * 40 / imageWidth;
							[_imgArticle RWsetHeightAsConstraint:aspectHeight];
						}
					}];
	
	NSString *titleString = [NSString stringWithFormat:@"%@: %@", _sessionObject.startTime, _sessionObject.title];
	[_lblTitle setText:titleString];
}

- (void)setAppearance{
	RWAppearanceHelper *helper = _appearanceHelper;
	[helper setBackgroundColor:self localName:Nil globalName:[RWLOOK INVISIBLE]];
}


@end
