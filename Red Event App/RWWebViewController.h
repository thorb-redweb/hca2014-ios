//
//  RWWebViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWWebViewController : RWBaseViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webBody;
@property(weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithPage:(RWXmlNode *)page;

-(IBAction)btnBackClicked;


@end
