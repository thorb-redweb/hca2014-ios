//
//  RWVenuePickerViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWDailySessionListViewController.h"

@interface RWVenuePickerViewController : UITableViewController

- (id)initWithController:(RWDailySessionListViewController *)controller page:(RWNode *)page;

@end
