//
//  RWTableNavigatorViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/20/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWTableNavigatorViewController.h"

@implementation RWTableNavigatorViewController {
    NSMutableArray *dataSource;
}


- (id)initWithName:(NSString *)name{
    self = [super initWithNibName:@"RWTableNavigator" bundle:nil name:name];
    if (self) {
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
@end
