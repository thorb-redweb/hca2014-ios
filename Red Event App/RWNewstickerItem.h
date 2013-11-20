//
//  RWNewstickerItem.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RWArticleVM.h"

@class RWXmlNode;

@interface RWNewstickerItem : UIViewController

@property(strong, nonatomic) IBOutlet UIView *vwContentFrame;

@property(strong, nonatomic) IBOutlet UILabel *lblTitle;
@property(strong, nonatomic) IBOutlet UIImageView *imgView;
@property(strong, nonatomic) IBOutlet UILabel *lblBody;
@property(strong, nonatomic) IBOutlet UIWebView *webView;

@property(strong, nonatomic) RWArticleVM *model;

@property(nonatomic) int leafNumber;

- (id)initWithModel:(RWArticleVM *)model page:(RWXmlNode *)page;

@end
