//
//  RWImageContentListViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIColor+RWColor.h"

#import "RWImageArticleListViewController.h"

#import "RWArticleDetailViewController.h"
#import "RWImageArticleListCell.h"

#import "RWDbArticles.h"

#import "RWArticleVM.h"
#import "RWAppearanceHelper.h"

@interface RWImageArticleListViewController ()
@end

@implementation RWImageArticleListViewController {
    NSArray *dataSource;
    int _catid;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name catid:(int)catid {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil name:name];
    if (self) {
        _catid = catid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    dataSource = [_db.Articles getVMListFromCatId:_catid];

    [self setAppearance];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK IMAGEARTICLELIST_BACKGROUNDCOLOR] globalName:[RWLOOK GLOBAL_BACKCOLOR]];
	[_tableView setBackgroundColor:[UIColor colorWithHexString:@"00000000"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RWArticleVM *model = dataSource[indexPath.row];
	
	RWNode *childPage = [_xml getPage:_childname];
	NSMutableDictionary *childDictionary = [[NSMutableDictionary alloc]initWithDictionary:[childPage getDictionaryFromNode]];
	[childDictionary setObject:model.articleid forKey:[RWPAGE ARTICLEID]];

	[_app.navController pushViewWithParameters:childDictionary];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWImageArticleListCell";
    RWImageArticleListCell *cell = (RWImageArticleListCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWImageArticleListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
		[self setCellAppearance:cell];
    }


    RWArticleVM *viewmodel = [dataSource objectAtIndex:indexPath.row];
    cell.lblTitle.text = viewmodel.title;
    cell.lblIntro.text = [viewmodel.introtext stringByStrippingHTML];

    [cell.lblTitle sizeToFit];
    cell.lblIntro.frame = [self calculateIntroTextFrameFromCell:cell];

    cell.imgThumb.image = [UIImage imageNamed:@"defaultIcon.jpeg"];
    if (viewmodel.introImagePath && ![viewmodel.introImagePath isEqual:@""]) {
        cell.model = viewmodel;
        [cell.imgThumb setImageWithURL:viewmodel.introImageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];
    }
    else if (![viewmodel.introImagePath isEqual:@""]) {
        cell.imgThumb.image = viewmodel.image;
    }

    return cell;
}

- (void)setCellAppearance:(RWImageArticleListCell *)cell{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:cell localName:[RWLOOK IMAGEARTICLELIST_BACKGROUNDCOLOR] globalName:[RWLOOK INVISIBLE]];
	
    [helper setLabelColor:cell.lblTitle localName:[RWLOOK IMAGEARTICLELIST_ITEMTITLECOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
    [helper setLabelFont:cell.lblTitle localSizeName:[RWLOOK IMAGEARTICLELIST_ITEMTITLESIZE] globalSizeName:[RWLOOK GLOBAL_ITEMTITLESIZE]
          localStyleName:[RWLOOK IMAGEARTICLELIST_ITEMTITLESTYLE] globalStyleName:[RWLOOK GLOBAL_ITEMTITLESTYLE]];
    [helper setLabelShadowColor:cell.lblTitle localName:[RWLOOK IMAGEARTICLELIST_ITEMTITLESHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:cell.lblTitle localName:[RWLOOK IMAGEARTICLELIST_ITEMTITLESHADOWOFFSET] globalName:[RWLOOK GLOBAL_ITEMTITLESHADOWOFFSET]];

    [helper setLabelColor:cell.lblIntro localName:[RWLOOK IMAGEARTICLELIST_TEXTCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
    [helper setLabelFont:cell.lblIntro localSizeName:[RWLOOK IMAGEARTICLELIST_TEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE]
          localStyleName:[RWLOOK IMAGEARTICLELIST_TEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
    [helper setLabelShadowColor:cell.lblIntro localName:[RWLOOK IMAGEARTICLELIST_TEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:cell.lblIntro localName:[RWLOOK IMAGEARTICLELIST_TEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];
}

- (CGRect)calculateIntroTextFrameFromCell:(RWImageArticleListCell *)cell {

    CGRect cellFrame = cell.frame;
    CGRect titleFrame = cell.lblTitle.frame;

    CGRect originalIntroFrame = cell.lblIntro.frame;
    CGSize fittedIntroSize = [cell.lblIntro sizeThatFits:originalIntroFrame.size];

    int newYBound = titleFrame.size.height + 2;
    int newHeight = cellFrame.size.height - newYBound - 2;

    if (fittedIntroSize.height < newHeight) {
        newHeight = fittedIntroSize.height;
    }

    CGRect newIntroFrame = CGRectMake(originalIntroFrame.origin.x, newYBound, originalIntroFrame.size.width, newHeight);
    return newIntroFrame;
}


@end
