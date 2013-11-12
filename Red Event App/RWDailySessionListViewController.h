//
//  RWDailySessionListViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

#import "RWVenueVM.h"

@interface RWDailySessionListViewController : RWBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UILabel *lblDate;
@property(weak, nonatomic) IBOutlet UIView *viewDateUnderline;
@property(weak, nonatomic) IBOutlet UIButton *btnPrevious;
@property(weak, nonatomic) IBOutlet UIButton *btnNext;
@property(weak, nonatomic) IBOutlet UIButton *btnVenuePicker;
@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic) RWVenueVM *filterVenue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name;

- (IBAction)previousDay:(id)sender;

- (IBAction)nextDay:(id)sender;

- (IBAction)openVenuePickingView:(id)sender;

@end
