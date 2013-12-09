//
//  RWCameraIntentViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 12/9/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWCameraIntentViewController.h"

@interface RWCameraIntentViewController ()

@end

@implementation RWCameraIntentViewController

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWCameraIntentViewController" bundle:nil page:page];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:@"Device has no camera"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles: nil];
        [errorAlertView show];
    }
    else {
        UIImagePickerController *picker = [[UIImagePickerController  alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;

        [self presentViewController:picker animated:YES completion:NULL];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *cameraImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];

    NSString *folderName = @"redApp";
    if([_page hasChild:[RWPAGE FOLDER]]){
        NSString *folderName = [_page getStringFromNode:[RWPAGE FOLDER]];
    }

    NSDate *datetimeNow = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss-SSS"];
    NSString *filename = [dateFormatter stringFromDate:datetimeNow];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@.png", [paths objectAtIndex:0], folderName, filename];

    [UIImagePNGRepresentation(cameraImage) writeToFile:filePath atomically:YES];

    [_app.navController pushViewWithPage:[RWPAGE CHILD]];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
