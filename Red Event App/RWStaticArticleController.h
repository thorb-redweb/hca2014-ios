//
//  RWStaticArticleController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWStaticArticleController : RWBaseViewController <UIWebViewDelegate>

@property(weak, nonatomic) IBOutlet UIWebView *webBody;
@property(weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithPage:(RWXmlNode *)page;

@end
