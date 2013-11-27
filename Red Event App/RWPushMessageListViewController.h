//
//  RWPushMessageListViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWPushMessageListViewController : RWBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithName:(NSString *)name;

@end
