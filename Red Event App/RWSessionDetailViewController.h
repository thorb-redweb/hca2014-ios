//
//  RWSessionDetailViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWSessionDetailViewController : RWBaseViewController <UIWebViewDelegate>

@property(weak, nonatomic) IBOutlet UIView *viewLabelsMargin;
@property(weak, nonatomic) IBOutlet UILabel *lblTitle;
@property(weak, nonatomic) IBOutlet UIButton *btnShare;
@property(weak, nonatomic) IBOutlet UIImageView *imgView;
@property(weak, nonatomic) IBOutlet UILabel *lblType;
@property(weak, nonatomic) IBOutlet UILabel *lblDate;
@property(weak, nonatomic) IBOutlet UILabel *lblPlace;
@property(weak, nonatomic) IBOutlet UILabel *lblTime;
@property(weak, nonatomic) IBOutlet UILabel *lblTypeText;
@property(weak, nonatomic) IBOutlet UILabel *lblDateText;
@property(weak, nonatomic) IBOutlet UILabel *lblPlaceText;
@property(weak, nonatomic) IBOutlet UILabel *lblTimeText;
@property(weak, nonatomic) IBOutlet UIButton *btnMap;
@property(weak, nonatomic) IBOutlet UIView *vwPricesContainer;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *cnstVwPricesContainerHeight;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *cnstVwPricesContainerDivider;
@property(weak, nonatomic) IBOutlet UIButton *btnTicket;
@property(weak, nonatomic) IBOutlet UIButton *btnCalendar;
@property(weak, nonatomic) IBOutlet UIView *vwBtnCalendar;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *cnstBtnCalendarWidth;
@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(weak, nonatomic) IBOutlet UILabel *lblBody;
@property(weak, nonatomic) IBOutlet UIWebView *webBody;
@property(weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithPage:(RWXmlNode *)page;

- (IBAction)shareToSocialMedia:(id)sender;

- (IBAction)btnMapPressed:(id)sender;
- (IBAction)btnTicketPressed:(id)sender;
- (IBAction)btnCalendarPressed:(id)sender;

@end
