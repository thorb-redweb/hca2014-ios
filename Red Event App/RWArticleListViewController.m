//
//  RWContentListViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"

#import "RWArticleListViewController.h"

#import "RWArticleDetailViewController.h"
#import "RWArticleListCell.h"

#import "RWArticleVM.h"


@interface RWArticleListViewController ()
@end

@implementation RWArticleListViewController {
    NSArray *dataSource;
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWArticleListViewController" bundle:nil page:page];
    if (self) {
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    int catid = [_page getIntegerFromNode:[RWPAGE CATID]];
    dataSource = [_db.Articles getVMListFromCatId:catid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    RWArticleVM *model = dataSource[indexPath.row];

//    RWArticleDetailViewController *viewController = [[RWArticleDetailViewController alloc] initWithNibName:@"RWContentDetailViewController" bundle:nil name:_childname articleid:[model.articleid intValue]];
//	[viewController setTitle:@"Temp"];
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
    static NSString *CellIdentifier = @"RWSimpleContentCell";
    RWArticleListCell *cell = (RWArticleListCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWSimpleContentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    RWArticleVM *viewmodel = [dataSource objectAtIndex:indexPath.row];
    cell.lblTitle.text = viewmodel.title;
    cell.lblIntro.text = [viewmodel.introtext stringByStrippingHTML];
    [cell.lblTitle sizeToFit];
    cell.lblIntro.frame = [self calculateIntroTextFrameFromCell:cell];

    return cell;
}

- (CGRect)calculateIntroTextFrameFromCell:(RWArticleListCell *)cell {

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
