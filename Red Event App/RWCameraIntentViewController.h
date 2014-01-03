//
//  RWCameraIntentViewController.h
//  Red App
//
//  Created by Thorbjørn Steen on 12/9/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"
#import "AVCamPreviewView.h"

@interface RWCameraIntentViewController : RWBaseViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet AVCamPreviewView *previewView;
@property (nonatomic, weak) IBOutlet UIButton *btnTakePicture;
@property (weak, nonatomic) IBOutlet UILabel *lblGoingToCamera;

- (id)initWithPage:(RWXmlNode *)page;

- (IBAction)snapStillImage:(id)sender;

@end
