//
//  RWNewstickerView.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIScrollView+RWScrollView.h"
#import "UIView+RWViewLayout.h"

#import "RWNewstickerView.h"
#import "RWNewstickerItem.h"

#import "RWArticleDetailViewController.h"

#import "RWDbArticles.h"
#import "RWAppearanceHelper.h"

@implementation RWNewstickerView {
    RWAppDelegate *_app;
    RWXMLStore *_xml;
    RWXmlNode *_page;

    NSArray *datasource;
    NSMutableArray *itemViewControllers;

    CGRect _basisFrame;

    NSTimer *_leafingTimer;
}

- (id)initWithFrame:(CGRect)frame subviewElement:(RWXmlNode *)page {
    self = [super initWithFrame:frame];
    if (self) {
        itemViewControllers = [[NSMutableArray alloc] init];
        _app = [[UIApplication sharedApplication] delegate];
        _xml = _app.xml;
        _page = page;
        _basisFrame = frame;

        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setPagingEnabled:YES];
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        int catid = [page getIntegerFromNode:[RWPAGE CATID]];
        datasource = [_app.db.Articles getVMListFromCatId:catid];

        [self addArticleItems];
        [self RWHorizontalContentSizeToFit];

        _leafingTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(turnPage:) userInfo:nil repeats:YES];

        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToArticle)];
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)goToArticle {
    RWArticleVM *model = datasource[self.currentLeaf];
    NSString *childname = [_page getStringFromNode:[RWPAGE CHILD]];
    RWArticleDetailViewController *controller = [[RWArticleDetailViewController alloc] initWithNibName:@"RWArticleDetailViewController" bundle:nil name:childname articleid:[model.articleid intValue]];
    [controller setTitle:@"Temp"];
}

- (void)addArticleItems {
    RWNewstickerItem *lastItem = nil;
    for (int i = 0; i < 3; i++) {
        RWArticleVM *model = datasource[i];
        RWNewstickerItem *newsItem = [[RWNewstickerItem alloc] initWithModel:model page:_page];

        [itemViewControllers addObject:newsItem];
        [self addSubview:newsItem.view];

        [self setArticleItemConstraints:newsItem.view lastItem:lastItem.view last:i == 2];

        lastItem = newsItem;
    }
}

- (void)setArticleItemConstraints:(UIView *)newsItemView lastItem:(UIView *)lastItemView last:(BOOL)last {
    [self RWpinChildToTop:newsItemView];
    [self RWpinChildToBottom:newsItemView];
    [newsItemView RWsetHeightAsConstraint:_basisFrame.size.height];
    if (lastItemView) {
        [self RWpinChildrenTogetherWithLeftChild:lastItemView RightChild:newsItemView];
    } else {
        [self RWpinChildToLeading:newsItemView];
    }
    if (last) {
        [self RWpinChildToTrailing:newsItemView];
    }
}

- (void)turnPage:(NSTimer *)theTimer {
    int nextLeaf = self.currentLeaf;
    if (self.currentLeaf < 2) {
        nextLeaf++;
    }
    else {
        nextLeaf = 0;
    }
    [self setContentOffset:CGPointMake(self.frame.size.width * nextLeaf, 0) animated:true];
}

- (int)currentLeaf {
    return self.contentOffset.x / self.frame.size.width;
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
