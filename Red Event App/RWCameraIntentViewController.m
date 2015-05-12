
#import <AVFoundation/AVFoundation.h>

#import "RWCameraIntentViewController.h"

static void * SessionRunningAndDeviceAuthorizedContext = &SessionRunningAndDeviceAuthorizedContext;
static void * CapturingStillImageContext = &CapturingStillImageContext;

@interface RWCameraIntentViewController ()

// For use in the storyboards.
- (IBAction)snapStillImage:(id)sender;
- (IBAction)focusAndExposeTap:(UITapGestureRecognizer *)gestureRecognizer;

// Utilities.
@property (nonatomic) BOOL lockInterfaceRotation;

@end

@implementation RWCameraIntentViewController{
	RWCameraHandler *cameraHandler;
}

-(id)initWithPage:(RWXmlNode *)page{
	if(self = [super initWithNibName:@"RWCameraIntentViewController" bundle:Nil page:page]){

	}
	return self;
}

- (BOOL)isSessionRunningAndDeviceAuthorized
{
    return [[cameraHandler session] isRunning] && [cameraHandler isDeviceAuthorized];
}

+ (NSSet *)keyPathsForValuesAffectingSessionRunningAndDeviceAuthorized
{
    return [NSSet setWithObjects:@"session.running", @"deviceAuthorized", nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
	//Setup cameraHandler
	cameraHandler = [[RWCameraHandler alloc] initWithPage:_page];
	cameraHandler.delegate = self;
	[cameraHandler initialize];
	
    // Setup the preview view
    [[self previewView] setSession:[cameraHandler getSession]];
	
	[self setAppearance];
	[self setText];
}

-(void)setAppearance{
    RWAppearanceHelper *helper = _appearanceHelper;

    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

	[helper.button setBackButtonStyle:_btnTakePicture];
}

-(void)setText{
    RWTextHelper *helper = _textHelper;

    [helper setButtonText:_btnTakePicture textName:[RWTEXT CAMERAINTENT_CAMERABUTTON] defaultText:[RWDEFAULTTEXT CAMERAINTENT_CAMERABUTTON]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[cameraHandler openCamera];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [cameraHandler shutdown];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    // Disable autorotation of the interface when recording is in progress.
    return ![self lockInterfaceRotation];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)toInterfaceOrientation];
}

#pragma mark Actions
- (IBAction)snapStillImage:(id)sender
{
	[cameraHandler snapStillImage:_previewView];}

- (void)continueToNextPage:(bool)imagesaved{
	RWXmlNode *nextPage = [_xml getPage:[_page getStringFromNode:[RWPAGE CHILD]]];
	nextPage = [nextPage deepClone];
	if(imagesaved){
		[nextPage addNodeWithName:[RWPAGE FILEPATH] value:[cameraHandler filePath]];
	}
	if([_page hasChild:[RWPAGE REDUPLOADFOLDERID]]){
		[nextPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:[_page getStringFromNode:[RWPAGE REDUPLOADFOLDERID]]];
	}
	[nextPage addNodeWithName:[RWPAGE POPTWICE] value:@"YES"];
	
	[_app.navController pushViewWithPage:nextPage];
}

- (IBAction)focusAndExposeTap:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Focus Tapped");
    CGPoint devicePoint = [(AVCaptureVideoPreviewLayer *)[[self previewView] layer] captureDevicePointOfInterestForPoint:[gestureRecognizer locationInView:[gestureRecognizer view]]];
	[cameraHandler focusWithModeAutoFocus:devicePoint];
}

- (void)subjectAreaDidChange:(NSNotification *)notification
{
    CGPoint devicePoint = CGPointMake(.5, .5);
    [cameraHandler focusWithModeContinuousAutoFocus:devicePoint];
}

#pragma mark UI
- (void)enableSnapPictureButton{
	[_btnTakePicture setEnabled:YES];
}

- (void)disableSnapPictureButton{
	[_btnTakePicture setEnabled:NO];
}

- (void)runStillImageCaptureAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[self previewView] layer] setOpacity:0.0];
        [UIView animateWithDuration:1 animations:^{
            [[[self previewView] layer] setOpacity:1.0];
        }];
    });
}
@end