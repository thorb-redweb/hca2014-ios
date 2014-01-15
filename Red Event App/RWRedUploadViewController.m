//
//  RWRedUploadViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/15/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWRedUploadViewController.h"

#import "RWSessionVM.h"

@interface RWRedUploadViewController ()

@end

@implementation RWRedUploadViewController{
	bool approved;
	RWSessionVM *session;
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWRedUploadViewController" bundle:nil page:page];
    if (self) {
		approved = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_scrMainScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	if ([_page hasChild:[RWPAGE SESSIONID]]) {
		int sessionId = [_page getIntegerFromNode:[RWPAGE SESSIONID]];
		session = [_db.Sessions getVMFromId:sessionId];
	}
	
	[self setAppearance];
	[self setText];
}

-(void)setControls{
	[_swcApproval setEnabled:NO];
	[_swcApproval setOn:NO];
	[_scrMainScrollView setBounces:[_page getBoolFromNode:[RWLOOK SCROLLBOUNCES]]];
}

-(void)setAppearance{
    RWAppearanceHelper *helper = _appearanceHelper;
	
    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[helper setBackgroundTileImageOrColor:_vwScrollBackground localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper.button setCustomStyle:_btnBack tag:@"topbutton" defaultColor:[RWLOOK DEFCOLOR_ALT] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper.button setCustomStyle:_btnTopRight tag:@"topbutton" defaultColor:[RWLOOK DEFCOLOR_ALT] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	
	[helper.button setCustomStyle:_btnBack tag:@"bottombutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper.button setCustomStyle:_btnTopRight tag:@"bottombutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	
	[helper.label setTitleStyle:_lblTitle];
	
	[helper setBackgroundColor:_vwApprovalBox localName:[RWLOOK REDUPLOAD_APPROVALBOXCOLOR] globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	[helper.label setAltTextStyle:_lblApprovalStatement];
	[helper.label setAltTextStyle:_lblApprovalStatus];
}

-(void)setText{
    RWTextHelper *helper = _textHelper;
	
    [helper setButtonText:_btnBack textName:[RWTEXT REDUPLOAD_BACKBUTTON] defaultText:[RWDEFAULTTEXT REDUPLOAD_BACKBUTTON]];
    [helper setButtonText:_btnTopRight textName:[RWTEXT REDUPLOAD_TOPRIGHTBUTTON] defaultText:[RWDEFAULTTEXT REDUPLOAD_TOPRIGHTBUTTON]];
	[_lblTitle setText:session.title];
	[helper setTextFieldPlaceHolderText:_txtPictureText textName:[RWTEXT REDUPLOAD_PICTURETEXTHINT] defaultText:[RWDEFAULTTEXT REDUPLOAD_PICTURETEXTHINT]];
	[helper setText:_lblApprovalStatement textName:[RWTEXT REDUPLOAD_APPROVALSTATEMENT] defaultText:[RWDEFAULTTEXT REDUPLOAD_APPROVALSTATEMENT]];
	[helper setText:_lblApprovalStatus textName:[RWTEXT REDUPLOAD_APPROVALSTATUSNO] defaultText:[RWDEFAULTTEXT REDUPLOAD_APPROVALSTATUSNO]];
    [helper setButtonText:_btnBottomLeft textName:[RWTEXT REDUPLOAD_BOTTOMLEFTBUTTONUNAPPROVED] defaultText:[RWDEFAULTTEXT REDUPLOAD_BOTTOMLEFTBUTTONUNAPPROVED]];
    [helper setButtonText:_btnDeletePicture textName:[RWTEXT REDUPLOAD_DELETEPICTUREBUTTON] defaultText:[RWDEFAULTTEXT REDUPLOAD_DELETEPICTUREBUTTON]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	if([_page hasChild:[RWPAGE FILEPATH]]){
        NSString *imagePath = [_page getStringFromNode:[RWPAGE FILEPATH]];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [_imgPicture setImage:image];
		
        CGSize size = image.size;
        size = CGSizeMake(0, 0);
		
		if(!image){
			[_btnTopRight setEnabled:NO];
			[_btnBottomLeft setEnabled:NO];
			[_btnDeletePicture setEnabled:NO];
	        DDLogError(@"No image exists for given path");
		}
    }
    else {
		[_btnTopRight setEnabled:NO];
		[_btnBottomLeft setEnabled:NO];
		[_btnDeletePicture setEnabled:NO];
        DDLogError(@"No filepath provided for image");
    }
}

- (IBAction)backButtonClicked:(id)sender{
	[_app.navController popPage];
}

- (IBAction)topRightButtonClicked:(id)sender{
	RWXmlNode *nextPage = [_xml getPage:_childname];
	if ([_page hasChild:[RWPAGE SESSIONID]]) {
		[nextPage addNodeWithName:[RWPAGE SESSIONID] value:[_page getStringFromNode:[RWPAGE SESSIONID]]];
	}	
    [_app.navController pushViewWithPage:nextPage];
}

- (IBAction)bottomLeftButtonClicked:(id)sender{
	
	if (!approved) {
        RWTextHelper *helper = _textHelper;
		approved = YES;
		[_swcApproval setOn:YES animated:YES];
		[helper setText:_lblApprovalStatus textName:[RWTEXT REDUPLOAD_APPROVALSTATUSYES] defaultText:[RWDEFAULTTEXT REDUPLOAD_APPROVALSTATUSYES]];
		[helper setButtonText:_btnBottomLeft textName:[RWTEXT REDUPLOAD_BOTTOMLEFTBUTTONAPPROVED] defaultText:[RWDEFAULTTEXT REDUPLOAD_BOTTOMLEFTBUTTONAPPROVED]];
    } else {
        
    }
	
}

- (IBAction)deletePictureButtonClicked:(id)sender{
	NSString *filePath = [_page getStringFromNode:[RWPAGE FILEPATH]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager removeItemAtPath:filePath error:nil];
	
	[_app.navController popPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
