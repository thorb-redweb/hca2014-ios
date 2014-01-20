//
//  RWRedUploadFolderViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/13/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWRedUploadFolderViewController : RWBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *scrTableScrollView;
@property (weak, nonatomic) IBOutlet UIView *vwTableBackground;
@property (weak, nonatomic) IBOutlet UITableView *lstSessions;

- (id)initWithPage:(RWXmlNode *)page;

@end
