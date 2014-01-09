#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface AVCamPreviewView : UIView

- (void)setSession:(AVCaptureSession *)session;

@end