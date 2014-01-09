#import "AVCamPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@implementation AVCamPreviewView{
	AVCaptureVideoPreviewLayer *previewLayer;
}

- (void)setSession:(AVCaptureSession *)session{
	previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	[self.layer addSublayer: previewLayer];
	previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	previewLayer.frame = self.bounds;
}

@end
