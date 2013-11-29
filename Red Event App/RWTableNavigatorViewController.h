//
//  RWTableNavigatorViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/20/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//



#import "RWBaseViewController.h"

@interface RWTableNavigatorViewController : RWBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithPage:(RWXmlNode *)page;

@end
