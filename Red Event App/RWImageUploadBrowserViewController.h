//
//  RWImageUploadBrowserViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 12/10/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWImageUploadBrowserViewController : RWBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *lstImageFiles;

- (id)initWithPage:(RWXmlNode *)page;
@end
