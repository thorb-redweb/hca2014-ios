//
//  RWImageContentListViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"
#import "RWHandler_GetImage.h"

@interface RWImageArticleListViewController : RWBaseViewController <UITabBarDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name catid:(int)catid;

@end