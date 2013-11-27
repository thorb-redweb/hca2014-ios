//
//  RWPushMessageDetailViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWPushMessageDetailViewController : RWBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *lblIntro;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblSenddate;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithName:(NSString *)name pushmessageid:(int)pushmessageid;

@end
