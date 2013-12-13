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

@implementation RWCameraIntentViewController{
    bool firstTime;
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWCameraIntentViewController" bundle:nil page:page];
    if (self) {
        firstTime = true;
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
                                                           otherButtonTitles:nil];
        [errorAlertView show];
        [_app.navController popPage];
    }
    else if(firstTime){
        UIImagePickerController *picker = [[UIImagePickerController  alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;

        firstTime = false;

        [self presentViewController:picker animated:YES completion:NULL];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *cameraImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];

    NSString *folderName = @"redApp";
    if([_page hasChild:[RWPAGE FOLDER]]){
        folderName = [_page getStringFromNode:[RWPAGE FOLDER]];
    }

    NSDate *datetimeNow = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss-SSS"];
    NSString *filename = [NSString stringWithFormat:@"%@.png",[dateFormatter stringFromDate:datetimeNow]];

    NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [applicationDocumentsDir stringByAppendingPathComponent:folderName];
    NSString *filePath = [folderPath stringByAppendingPathComponent:filename];

    NSError *error = nil;
    if(![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]){
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:NO
                                                        attributes:nil error:&error];
    }

    if(error != nil){
        NSLog(@"Create directory error: %@", error);
    }

    [UIImagePNGRepresentation(cameraImage) writeToFile:filePath options:NSDataWritingAtomic error:&error];

    if(error != nil){
        NSLog(@"Error in saving image to disk. Error : %@", error);
    }

    RWXmlNode *nextPage = [_xml getPage:[_page getStringFromNode:[RWPAGE CHILD]]];
    nextPage = [nextPage deepClone];
    [nextPage addNodeWithName:[RWPAGE FILEPATH] value:filePath];

    [_app.navController pushViewWithPage:nextPage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];

    [_app.navController popPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
