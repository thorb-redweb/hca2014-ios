//
//  RWSessionListViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "NSString+RWString.h"

#import "RWSessionListViewController.h"
#import "RWAppDelegate.h"
#import "RWDbInterface.h"

#import	"RWSessionDetailViewController.h"
#import "RWDailySessionListItem.h"

#import "RWSessionVM.h"

@interface RWSessionListViewController ()
@end

@implementation RWSessionListViewController {
    NSArray *dataSource;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil name:name];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [_db.Sessions getVMList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RWAppDelegate *app = [[UIApplication sharedApplication] delegate];
    RWSessionVM *model = dataSource[indexPath.row];

    NSMutableDictionary *sessiondetailVariables = [[NSMutableDictionary alloc] init];
    [sessiondetailVariables setObject:@"SessionDetail" forKey:@"type"];
    [sessiondetailVariables setObject:_childname forKey:@"name"];
    [sessiondetailVariables setObject:model.sessionid forKey:@"sessionid"];

    [app.navController pushViewWithParameters:sessiondetailVariables];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWDailySessionListItem";
    RWDailySessionListItem *cell = (RWDailySessionListItem *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWDailySessionListItem" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

//    RWSessionVM *viewmodel = [dataSource objectAtIndex:indexPath.row];
//    cell.lblTitle.text = viewmodel.title;
//    cell.lblTime.text = [NSString stringWithFormat:@"kl. %@ - %@, %@", viewmodel.startTime, viewmodel.endTime, viewmodel.startDateShort];
//    cell.lblPlace.text = viewmodel.venue;
//    cell.lblSummary.text = viewmodel.summary;
//	[cell.lblTitle sizeToFit];
//	cell.lblIntro.frame = [self calculateIntroTextFrameFromCell:cell];

    return cell;
}

//- (CGRect)calculateIntroTextFrameFromCell:(RWDailySessionListItem *)cell {
//
//    CGRect cellFrame = cell.frame;
//    CGRect titleFrame = cell.lblTitle.frame;
//
//    CGRect originalIntroFrame = cell.lblTime.frame;
//    CGSize fittedIntroSize = [cell.lblTime sizeThatFits:originalIntroFrame.size];
//
//    int newYBound = titleFrame.size.height + 2;
//    int newHeight = cellFrame.size.height - newYBound - 2;
//
//    if (fittedIntroSize.height < newHeight) {
//        newHeight = fittedIntroSize.height;
//    }
//
//    CGRect newIntroFrame = CGRectMake(originalIntroFrame.origin.x, newYBound, originalIntroFrame.size.width, newHeight);
//    return newIntroFrame;
//}

@end
