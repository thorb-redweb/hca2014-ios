//
//  RWCameraHandler.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/8/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "UIImage+RWImage.h"

#import "RWCameraHandler.h"
#import "RWCameraIntentViewController.h"

static void * SessionRunningAndDeviceAuthorizedContext = &SessionRunningAndDeviceAuthorizedContext;
static void * CapturingStillImageContext = &CapturingStillImageContext;

@interface RWCameraHandler()

// Session management.
@property (nonatomic) dispatch_queue_t sessionQueue; // Communicate with the session and other session objects on this queue.
@property (nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;

// Utilities.
@property (nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic) id runtimeErrorHandlingObserver;

@end

@implementation RWCameraHandler{

}

-(id)initWithPage:(RWXmlNode *)page{
	if(self = [super init]){
		NSString *folderName = @"redApp";
		if([page hasChild:[RWPAGE FOLDER]]){
			folderName = [page getStringFromNode:[RWPAGE FOLDER]];
		}
		NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		
		_folderPath = [applicationDocumentsDir stringByAppendingPathComponent:folderName];
	}
	return self;
}

-(void)initialize{
	// Create the AVCaptureSession
    _session = [[AVCaptureSession alloc] init];
    [self setSession:_session];
	_session.sessionPreset = AVCaptureSessionPresetMedium; //This line decides the format (size) of the picture
	
	AVCaptureDevice *videoDevice = [RWCameraHandler deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
    
    // Check for device authorization
    [self checkDeviceAuthorizationStatus];
    
    // Dispatch the rest of session setup to the sessionQueue so that the main queue isn't blocked.
    dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    [self setSessionQueue:sessionQueue];
    
    dispatch_async(sessionQueue, ^{
        [self setBackgroundRecordingID:UIBackgroundTaskInvalid];
        
        NSError *error = nil;
        
        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        
        if (error)
        {
            NSLog(@"%@", error);
        }
        
        if ([_session canAddInput:videoDeviceInput])
        {
            [_session addInput:videoDeviceInput];
            [self setVideoDeviceInput:videoDeviceInput];
        }
        
        AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        if ([_session canAddOutput:stillImageOutput])
        {
            [stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
            [_session addOutput:stillImageOutput];
            [self setStillImageOutput:stillImageOutput];
        }
    });

}

-(AVCaptureSession *)getSession{
	return _session;
}

-(void)openCamera{
	dispatch_async([self sessionQueue], ^{
        [self addObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:SessionRunningAndDeviceAuthorizedContext];
        [self addObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:CapturingStillImageContext];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectAreaDidChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self videoDeviceInput] device]];
        
        __weak RWCameraHandler *weakSelf = self;
        [self setRuntimeErrorHandlingObserver:[[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureSessionRuntimeErrorNotification object:[self session] queue:nil usingBlock:^(NSNotification *note) {
            RWCameraHandler *strongSelf = weakSelf;
            dispatch_async([strongSelf sessionQueue], ^{
                // Manually restarting the session since it must have been stopped due to an error.
                [[strongSelf session] startRunning];
            });
        }]];
        [[self session] startRunning];
    });
}

-(void)shutdown{
	dispatch_async([self sessionQueue], ^{
        [[self session] stopRunning];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self videoDeviceInput] device]];
        [[NSNotificationCenter defaultCenter] removeObserver:[self runtimeErrorHandlingObserver]];
        
        [self removeObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" context:SessionRunningAndDeviceAuthorizedContext];
        [self removeObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" context:CapturingStillImageContext];
    });
}

#pragma mark Actions

-(void)snapStillImage:(AVCamPreviewView *)previewView{
	dispatch_async([self sessionQueue], ^{
        // Update the orientation on the still image output video connection before capturing.
		
        [[[self stillImageOutput] connectionWithMediaType:AVMediaTypeVideo] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        
        // Flash set to Auto for Still Capture
        [RWCameraHandler setFlashMode:AVCaptureFlashModeAuto forDevice:[[self videoDeviceInput] device]];
        
		_filePath = [self getFilePathWithFolderPath:_folderPath];
		
		// Capture a still image.
        [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:[[self stillImageOutput] connectionWithMediaType:AVMediaTypeVideo] completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            
			bool imagesaved = false;
            if (imageDataSampleBuffer)
            {
				imagesaved = true;
                
                UIImage *image = [self getImageWithBufferData:imageDataSampleBuffer];
                
				NSError *error = nil;
				if(![[NSFileManager defaultManager] fileExistsAtPath:_folderPath isDirectory:nil]){
					[[NSFileManager defaultManager] createDirectoryAtPath:_folderPath withIntermediateDirectories:NO
															   attributes:nil error:&error];
				}
				
				if(error != nil){
                    NSLog(@"Create directory error: %@", error);
					imagesaved = false;
				}
				
				[UIImagePNGRepresentation(image) writeToFile:_filePath options:NSDataWritingAtomic error:&error];
				
				if(error != nil){
                    NSLog(@"Error in saving image to disk. Error : %@", error);
					imagesaved = false;
				}
            }
			
			[_delegate continueToNextPage:imagesaved];
        }];
    });
	
}

-(NSString *)getFilePathWithFolderPath:(NSString *)folderPath{
	NSDate *datetimeNow = [[NSDate alloc] init];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss-SSS"];
	NSString *filename = [NSString stringWithFormat:@"%@.png",[dateFormatter stringFromDate:datetimeNow]];
	
	return [folderPath stringByAppendingPathComponent:filename];
}

-(UIImage *)getImageWithBufferData:(CMSampleBufferRef)imageDataSampleBuffer{
	NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
	UIImage *image = [[UIImage alloc] initWithData:imageData];
	
	UIDevice *device = [UIDevice currentDevice];
	[device beginGeneratingDeviceOrientationNotifications];
	UIDeviceOrientation deviceOrientation = device.orientation;
	[device endGeneratingDeviceOrientationNotifications];
	
	if(deviceOrientation == UIDeviceOrientationPortrait){
		image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationRight];
	}
	else if(deviceOrientation == UIDeviceOrientationPortraitUpsideDown){
		image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationLeft];
	}
	else if(deviceOrientation == UIDeviceOrientationLandscapeLeft){
		image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUp];
	}
	else if(deviceOrientation == UIDeviceOrientationLandscapeRight){
		image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationDown];
	}
	
	UIImage *resultImage = [image fixOrientationAndScale];
	CGSize size = resultImage.size;
	size = CGSizeMake(0, 0);
	
	return resultImage;
}

#pragma mark Device Configuration

+ (void)setFlashMode:(AVCaptureFlashMode)flashMode forDevice:(AVCaptureDevice *)device
{
    if ([device hasFlash] && [device isFlashModeSupported:flashMode])
    {
        NSError *error = nil;
        if ([device lockForConfiguration:&error])
        {
            [device setFlashMode:flashMode];
            [device unlockForConfiguration];
        }
        else
        {
            NSLog(@"%@", error);
        }
    }
}

-(void)focusWithModeAutoFocus:(CGPoint)devicePoint{
	[self focusWithMode:AVCaptureFocusModeAutoFocus exposeWithMode:AVCaptureExposureModeAutoExpose atDevicePoint:devicePoint monitorSubjectAreaChange:YES];
}

-(void)focusWithModeContinuousAutoFocus:(CGPoint)devicePoint{
	[self focusWithMode:AVCaptureFocusModeContinuousAutoFocus exposeWithMode:AVCaptureExposureModeContinuousAutoExposure atDevicePoint:devicePoint monitorSubjectAreaChange:NO];
}

- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposeWithMode:(AVCaptureExposureMode)exposureMode atDevicePoint:(CGPoint)point monitorSubjectAreaChange:(BOOL)monitorSubjectAreaChange
{
    dispatch_async([self sessionQueue], ^{
        AVCaptureDevice *device = [[self videoDeviceInput] device];
        NSError *error = nil;
        if ([device lockForConfiguration:&error])
        {
            if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:focusMode])
            {
                [device setFocusMode:focusMode];
                [device setFocusPointOfInterest:point];
            }
            if ([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:exposureMode])
            {
                [device setExposureMode:exposureMode];
                [device setExposurePointOfInterest:point];
            }
            [device setSubjectAreaChangeMonitoringEnabled:monitorSubjectAreaChange];
            [device unlockForConfiguration];
        }
        else
        {
            NSLog(@"%@", error);
        }
    });
}

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = [devices firstObject];
    
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position)
        {
            captureDevice = device;
            break;
        }
    }
    
    return captureDevice;
}


-(void)checkDeviceAuthorizationStatus
{
    NSString *mediaType = AVMediaTypeVideo;
    
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        if (granted)
        {
            //Granted access to mediaType
            [self setDeviceAuthorized:YES];
        }
        else
        {
            //Not granted access to mediaType
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"AVCam!"
                                            message:@"AVCam doesn't have permission to use Camera, please change privacy settings"
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
                [self setDeviceAuthorized:NO];
            });
        }
    }];
}

#pragma mark UI

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == CapturingStillImageContext)
    {
        BOOL isCapturingStillImage = [change[NSKeyValueChangeNewKey] boolValue];
        
        if (isCapturingStillImage)
        {
            [_delegate runStillImageCaptureAnimation];
        }
    }
    else if (context == SessionRunningAndDeviceAuthorizedContext)
    {
        BOOL isRunning = [change[NSKeyValueChangeNewKey] boolValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isRunning)
            {
				[_delegate enableSnapPictureButton];
            }
            else
            {
				[_delegate disableSnapPictureButton];
            }
        });
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
