//
//  RWAdventWindowViewController.h
//  Jule App
//
//  Created by Thorbjørn Steen on 10/29/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWAdventWindowViewController : RWBaseViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIView *vwContentView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;
@property (weak, nonatomic) IBOutlet UIWebView *webBody;
@property (weak, nonatomic) IBOutlet UILabel *lblBody;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithName:(NSString *)name articleid:(int)articleid;

-(IBAction)btnBackClicked;

@end
