//
//  RWCameraHandler.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/8/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVCamPreviewView;
@class RWCameraIntentViewController;
@class RWXmlNode;

@protocol RWDelegate_CameraHandler <NSObject>
@required
- (void)runStillImageCaptureAnimation;
- (void)continueToNextPage:(bool)imagesaved;
- (void)enableSnapPictureButton;
- (void)disableSnapPictureButton;
@end

@interface RWCameraHandler : NSObject {
    id <RWDelegate_CameraHandler> _delegate;
}

@property(strong, nonatomic) id delegate;

// Session management.
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic, getter = isDeviceAuthorized) BOOL deviceAuthorized;

// Paths
@property (nonatomic) NSString *folderPath;
@property (nonatomic) NSString *filePath;

-(id)initWithPage:(RWXmlNode *)page;
-(void)initialize;
-(AVCaptureSession *)getSession;
-(void)openCamera;
-(void)shutdown;

-(void)snapStillImage:(AVCamPreviewView *)viewController;
-(void)focusWithModeAutoFocus:(CGPoint)devicePoint;
-(void)focusWithModeContinuousAutoFocus:(CGPoint)devicePoint;

@end
