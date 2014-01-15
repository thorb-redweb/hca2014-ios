//
//  RWRedUploadViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/15/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWRedUploadViewController : RWBaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrMainScrollView;
@property (weak, nonatomic) IBOutlet UIView *vwScrollBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnTopRight;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;
@property (weak, nonatomic) IBOutlet UITextField *txtPictureText;
@property (weak, nonatomic) IBOutlet UIView *vwApprovalBox;
@property (weak, nonatomic) IBOutlet UILabel *lblApprovalStatement;
@property (weak, nonatomic) IBOutlet UILabel *lblApprovalStatus;
@property (weak, nonatomic) IBOutlet UISwitch *swcApproval;
@property (weak, nonatomic) IBOutlet UIButton *btnBottomLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnDeletePicture;

- (id)initWithPage:(RWXmlNode *)page;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)topRightButtonClicked:(id)sender;
- (IBAction)bottomLeftButtonClicked:(id)sender;
- (IBAction)deletePictureButtonClicked:(id)sender;

@end
