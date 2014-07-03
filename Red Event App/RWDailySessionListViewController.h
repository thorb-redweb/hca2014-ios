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

@interface RWDailySessionListViewController : RWBaseViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property(weak, nonatomic) IBOutlet UILabel *lblDate;
@property(weak, nonatomic) IBOutlet UIView *viewDateUnderline;
@property(weak, nonatomic) IBOutlet UIButton *btnPrevious;
@property(weak, nonatomic) IBOutlet UIButton *btnNext;
@property(weak, nonatomic) IBOutlet UIButton *btnTypePicker;
@property(weak, nonatomic) IBOutlet UIButton *btnVenuePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property(weak, nonatomic) IBOutlet UITableView *lstTableView;

- (id)initWithPage:(RWXmlNode *)page;

- (IBAction)previousDay:(id)sender;

- (IBAction)nextDay:(id)sender;

- (IBAction)openTypePickingView:(id)sender;
- (IBAction)openVenuePickingView:(id)sender;
- (IBAction)openSearchView:(id)sender;

@end
