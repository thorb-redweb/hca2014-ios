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
	
	[self setAppearance];
	[self setText];
}

-(void)setAppearance{
    RWAppearanceHelper *helper = _appearanceHelper;

    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    NSArray *buttons = [[NSArray alloc] initWithObjects: _btnBrowser, _btnUploading, nil];

    [helper.button setBackgroundImageOrColorsForList:buttons localImageName:[RWLOOK BUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BUTTONBACKGROUNDCOLOR] globalColorName:[RWLOOK DEFAULT_ALTCOLOR]];
    [helper.button setTitleColorsForList:buttons localName:[RWLOOK BUTTONTEXTCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
    [helper.button setTitleFontsForList:buttons localSizeName:[RWLOOK BUTTONTEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:[RWLOOK BUTTONTEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.button setTitleShadowColorsForList:buttons localName:[RWLOOK BUTTONTEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTSHADOWCOLOR]];
    [helper.button setTitleShadowOffsetsForList:buttons localName:[RWLOOK BUTTONTEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

-(void)setText{
    RWTextHelper *helper = _textHelper;

    [helper setButtonText:_btnBrowser textName:[RWTEXT IMAGEUPLOADER_BROWSERBUTTON] defaultText:[RWDEFAULTTEXT IMAGEUPLOADER_BROWSERBUTTON]];
    [helper setButtonText:_btnUploading textName:[RWTEXT IMAGEUPLOADER_UPLOADBUTTON] defaultText:[RWDEFAULTTEXT IMAGEUPLOADER_UPLOADBUTTON]];
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
