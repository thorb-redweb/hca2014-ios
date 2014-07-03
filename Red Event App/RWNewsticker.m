//
//  RWNewsTicker.m
//  Red App
//
//  Created by Thorbjørn Steen on 2/25/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "UIColor+RWColor.h"
#import "UIImageView+WebCache.h"
#import "UIView+RWViewLayout.h"
#import "RWNewsticker.h"
#import "RWNewstickerCell.h"
#import "RWArticleVM.h"

@implementation RWNewsticker {
	RWAppDelegate *_app;
	
	NSString *_childname;
	NSMutableArray *_datasource;
	NSArray *_cells;
	float _pageWidth;
	
	NSTimer *_pageTimer;
}

-(void)initializeWithDatasource:(NSMutableArray *)datasource newsCells:(NSArray *)cells app:(RWAppDelegate *)app childname:(NSString *)childname{
	_datasource = datasource;
	_cells = cells;
	_pageWidth = self.bounds.size.width;
	
	_app = app;
	_childname = childname;
	
	int numberNews = _datasource.count > 3 ? 3 : _datasource.count;
	
	for (int i = 0; i < numberNews; i++) {
		RWNewstickerCell *cell = _cells[i];
		
		RWArticleVM *article = _datasource[i];
		cell.lblTitle.text = article.title;
		cell.lblBody.text = article.introtextWithoutHtml;
		NSURL *imagePath = article.introImageUrl;
		[cell.imgImage setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];
	}
	
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
	[recognizer setNumberOfTouchesRequired:1];
	[self addGestureRecognizer:recognizer];
	recognizer.delegate = self;
}

-(void)handleTapFrom:(UITapGestureRecognizer *)recognizer{
	
	NSNumber *articleid = [_datasource[[self currentPage]] articleid];
	
	RWXmlNode *childNode = [[_app.xml getPage:_childname] deepClone];
	[childNode addNodeWithName:[RWPAGE ARTICLEID] value:articleid];
	[_app.navController pushViewWithPage:childNode];
}

-(void)startPaging{
	_pageTimer = [NSTimer scheduledTimerWithTimeInterval:12 target:self selector:@selector(scrollPages) userInfo:Nil repeats:YES];
	[_pageTimer fire];
}

-(void)stopPaging{
	[_pageTimer invalidate];
}

-(void)scrollPages{
	int pageToScrollTo = ([self currentPage]+1)%_datasource.count;
	[self scrollToPage:pageToScrollTo];
	CGSize bounds = self.contentSize;
	CGSize bounds2 = self.bounds.size;
	if(bounds.width == 0 || bounds2.width == 0){}
}

-(void)scrollToPage:(NSInteger)aPage{
	[self setContentOffset:CGPointMake(aPage * _pageWidth, 0) animated:YES];
}

-(int)currentPage{
	return [self contentOffset].x/_pageWidth;
}

@end
