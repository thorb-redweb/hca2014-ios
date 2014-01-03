//
//  RWImageUploaderViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 12/9/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"
#import "RWImageUploaderViewController.h"

@interface RWImageUploaderViewController ()

@end

@implementation RWImageUploaderViewController

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWImageUploaderViewController" bundle:nil page:page];
    if (self) {
        _page = [_page deepClone];
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

    if([_page hasChild:[RWPAGE FILEPATH]]){
        NSString *imagePath = [_page getStringFromNode:[RWPAGE FILEPATH]];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [_imgToUpload setImage:image];
		
		CGSize size = image.size;
		size = CGSizeMake(0, 0);
    }
    else {
        [self startBrowser];
    }
}

- (IBAction)startBrowserButton:(id)sender {
    [self startBrowser];
}

- (void)startBrowser{
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    [nodes addObject:[[RWXmlNode alloc] initWithName:[RWPAGE NAME] value:_name]];
    [nodes addObject:[[RWXmlNode alloc] initWithName:[RWPAGE TYPE] value:[RWTYPE FILEBROWSER]]];
    [nodes addObject:[[RWXmlNode alloc] initWithName:[RWPAGE PARENTPAGE] value:_page]];
    if([_page hasChild:[RWPAGE FOLDER]]){
        [nodes addObject:[[RWXmlNode alloc] initWithName:[RWPAGE FOLDER] value:[_page getStringFromNode:[RWPAGE FOLDER]]]];
    }
    else {
        [nodes addObject:[[RWXmlNode alloc] initWithName:[RWPAGE FOLDER] value:@"redApp"]];
    }
    RWXmlNode *nextPage = [[RWXmlNode alloc] initWithName:[RWPAGE PAGE] value:nodes];

    [_app.navController pushViewWithPage:nextPage];
}

- (IBAction)uploadImageButton:(id)sender {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
