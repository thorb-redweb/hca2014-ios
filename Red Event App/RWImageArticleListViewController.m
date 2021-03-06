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
}


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWImageArticleListViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	//TODO: Hacks!!!! Tableview doesn't call numberOfRowsInSection if TranslatesAutoresizingMaskIntoConstraints is set to NO, and the page is in a swipeview. The below if construct "solves" that problem.
	if(![_xml swipeViewHasPage:_page]){
		[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}

	if([_page hasChild:[RWPAGE CATID]]){
		int catid = [_page getIntegerFromNode:[RWPAGE CATID]];
		dataSource = [_db.Articles getVMListFromCatId:catid];
	}
	else{
		NSArray *catids = [_page getNSNumberArrayFromNode:[RWPAGE CATIDS]];
		dataSource = [_db.Articles getVMListFromCatIds:catids];
	}

    [self setAppearance];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[_lstTableView setBackgroundColor:[UIColor colorWithHexString:@"00000000"]];
	
	[helper setScrollBounces:_lstTableView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    [_lstTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RWArticleVM *model = dataSource[indexPath.row];
	
	RWXmlNode *childPage = [[_xml getPage:_childname] deepClone];
	[childPage addNodeWithName:[RWPAGE ARTICLEID] value:model.articleid];

    [_app.navController pushViewWithPage:childPage];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Table view data source

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
		[cell.vwContentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.imgThumb attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:cell.imgThumb attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    }


    RWArticleVM *viewmodel = [dataSource objectAtIndex:indexPath.row];
    cell.lblTitle.text = viewmodel.title;
    cell.lblIntro.text = [viewmodel.introtext stringByStrippingHTML];

    cell.imgThumb.image = [UIImage imageNamed:@"defaultIcon.jpeg"];
    [cell.imgThumb setImageWithURL:viewmodel.introImageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];

    return cell;
}

- (void)setCellAppearance:(RWImageArticleListCell *)cell{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:cell localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK INVISIBLE]];

	[helper.label setBackItemTitleStyle:cell.lblTitle];

	[helper.label setBackTextStyle:cell.lblIntro];
}

@end
