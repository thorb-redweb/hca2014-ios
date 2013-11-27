//
//  RWPushMessageSubscriberViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/26/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWPushMessageSubscriberViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblPageDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
