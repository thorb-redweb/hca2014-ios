//
//  RWImageUploaderViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 12/9/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@class RWXmlNode;

@interface RWImageUploaderViewController : RWBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgToUpload;
@property (weak, nonatomic) IBOutlet UIButton *btnBrowser;
@property (weak, nonatomic) IBOutlet UIButton *btnUploading;

- (id)initWithPage:(RWXmlNode *)page;

-(IBAction)startBrowserButton:(id)sender;
-(IBAction)uploadImageButton:(id)sender;

@end
