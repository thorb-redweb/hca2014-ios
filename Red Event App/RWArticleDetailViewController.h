//
//  RWContentDetailViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/21/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWArticleDetailViewController : RWBaseViewController <UIWebViewDelegate>

@property(weak, nonatomic) IBOutlet UILabel *lblTitle;
@property(weak, nonatomic) IBOutlet UIView *vwContentView;
@property(weak, nonatomic) IBOutlet UIImageView *imgView;
@property(weak, nonatomic) IBOutlet UIWebView *webBody;
@property(weak, nonatomic) IBOutlet UILabel *lblBody;
@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name articleid:(int)contid;

-(IBAction)btnBackClicked;

@end