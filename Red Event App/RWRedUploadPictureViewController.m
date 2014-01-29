//
//  RWRedUploadPictureViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/15/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWRedUploadPictureViewController.h"

#import "RWVolatileDataStores.h"
#import "RWRedUploadDataStore.h"
#import "RWRedUploadServerFolder.h"

#import "RWDbSchemas.h"
#import "RWDbRedUploadImages.h"

@interface RWRedUploadPictureViewController ()

@end

@implementation RWRedUploadPictureViewController {
	RWRedUploadServerFolder *_folder;
	NSString *_imagePath;
	RedUploadImage *_redUploadImageObject;
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWRedUploadPictureViewController" bundle:nil page:page];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	[self setValues];
	[self setControls];
	[self setAppearance];
	[self setText];
}

-(void)setValues{
	int folderId = [_page getIntegerFromNode:[RWPAGE REDUPLOADFOLDERID]];
	RWRedUploadDataStore *redUpload = [_app.volatileDataStores getRedUpload];
	_folder = [redUpload getFolder:folderId];
	
	if([_page hasChild:[RWPAGE FILEPATH]]){
        _imagePath = [_page getStringFromNode:[RWPAGE FILEPATH]];
		
		_redUploadImageObject = [_db.RedUploadImages getFromImagePath:_imagePath];
		if(!_redUploadImageObject){
			NSMutableDictionary *entry = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_folder.serverFolder, [RWDbSchemas RUI_SERVERFOLDER], _imagePath, [RWDbSchemas RUI_LOCALIMAGEPATH], nil];
			_redUploadImageObject = [_db.RedUploadImages createEntry:entry];
		}
    }
}

-(void)setControls{
	
	[_txtPictureText setText:_redUploadImageObject.text];
	
	[_vwTakePicture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topRightButtonClicked:)]];
	
	[_swcApproval setEnabled:NO];
	[_swcApproval setOn:_redUploadImageObject.approved.boolValue animated:YES];
}

-(void)setAppearance{
    RWAppearanceHelper *helper = _appearanceHelper;
	
    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper.button setCustomStyle:_btnBack tag:@"topbutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper setBackgroundAsShape:_btnBack localBackgroundColorName:@"topbuttonbackgroundcolor" globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:1 localBorderColorName:@"topbuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	
	[helper setBackgroundColor:_vwTakePicture localName:nil globalName:[RWLOOK INVISIBLE]];
	[helper setBackgroundAsShape:_vwFrontBox localBackgroundColorName:@"topbuttonbackgroundcolor" globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:1 localBorderColorName:@"topbuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	[helper.label setColor:_lblTakePicture localName:@"topbuttontextcolor" globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
	[helper.label setFont:_lblTakePicture localSizeName:@"topbuttontextsize" globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE] localStyleName:@"topbuttontextstyle" globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
	[helper.label setShadowColor:_lblTakePicture localName:@"topbuttontextshadowcolor" globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
	[helper.label setShadowOffset:_lblTakePicture localName:@"topbuttontextshadowoffset" globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	[helper setBackgroundColor:_imgTakePicture localName:@"camerabuttoniconcolor" globalName:[RWLOOK DEFAULT_ALTCOLOR]];
	[_imgTakePicture setImage:[_appearanceHelper.getter getImageFromLocalSourceWithLocalName:@"camerabuttonicon"]];
	
	[helper.label setTitleStyle:_lblTitle];
	
	[helper setBackgroundAsShape:_txtPictureText localBackgroundColorName:@"textboxbackgroundcolor" globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:1 localBorderColorName:@"textboxbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:5];
	
	[helper setBackgroundAsShape:_vwApprovalBox localBackgroundColorName:[RWLOOK REDUPLOADPICTUREVIEW_APPROVALBOXCOLOR] globalBackgroundColorName:[RWLOOK DEFAULT_BACKCOLOR] borderWidth:1 localBorderColorName:@"approvalboxbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	[helper.label setAltTextStyle:_lblApprovalStatement];
	[helper.label setAltTextStyle:_lblApprovalStatus];
	
	[helper.button setCustomStyle:_btnBottomLeft tag:@"uploadbutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper setBackgroundAsShapeWithGradiant:_btnBottomLeft localBackgroundColorName1:@"uploadbuttonbackgroundcolor" globalBackgroundColorName1:[RWLOOK DEFAULT_BACKCOLOR] localBackgroundColorName2:@"uploadbuttonbackgroundcolor2" globalBackgroundColorName2:[RWLOOK DEFAULT_BACKCOLOR]
								 borderWidth:1 localBorderColorName:@"uploadbuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
	
	[helper.button setCustomStyle:_btnDeletePicture tag:@"deletebutton" defaultColor:[RWLOOK DEFCOLOR_BACK] defaultSize:[RWLOOK DEFSIZE_ITEMTITLE]];
	[helper setBackgroundAsShapeWithGradiant:_btnDeletePicture localBackgroundColorName1:@"deletebuttonbackgroundcolor" globalBackgroundColorName1:[RWLOOK DEFAULT_BACKCOLOR]
				   localBackgroundColorName2:@"deletebuttonbackgroundcolor2" globalBackgroundColorName2:[RWLOOK DEFAULT_BACKCOLOR]
								 borderWidth:1 localBorderColorName:@"deletebuttonbordercolor" globalBorderColorName:[RWLOOK DEFAULT_BACKTEXTCOLOR] cornerRadius:15];
}

-(void)setText{
    RWTextHelper *helper = _textHelper;
	
    [helper setButtonText:_btnBack textName:[RWTEXT REDUPLOAD_BACKBUTTON] defaultText:[RWDEFAULTTEXT REDUPLOAD_BACKBUTTON]];
    [helper setText:_lblTakePicture textName:@"nextbutton" defaultText:[RWDEFAULTTEXT REDUPLOAD_TOPRIGHTBUTTON]];
	[_lblTitle setText:_folder.name];
	[helper setTextFieldPlaceHolderText:_txtPictureText textName:[RWTEXT REDUPLOAD_PICTURETEXTHINT] defaultText:[RWDEFAULTTEXT REDUPLOAD_PICTURETEXTHINT]];
	[helper setText:_lblApprovalStatement textName:[RWTEXT REDUPLOAD_APPROVALSTATEMENT] defaultText:[RWDEFAULTTEXT REDUPLOAD_APPROVALSTATEMENT]];
    [helper setButtonText:_btnDeletePicture textName:[RWTEXT REDUPLOAD_DELETEPICTUREBUTTON] defaultText:[RWDEFAULTTEXT REDUPLOAD_DELETEPICTUREBUTTON]];
	
	if(_redUploadImageObject.approved.boolValue){
		[helper setText:_lblApprovalStatus textName:[RWTEXT REDUPLOAD_APPROVALSTATUSNO] defaultText:[RWDEFAULTTEXT REDUPLOAD_APPROVALSTATUSYES]];
		[helper setButtonText:_btnBottomLeft textName:[RWTEXT REDUPLOAD_BOTTOMLEFTBUTTONAPPROVED] defaultText:[RWDEFAULTTEXT REDUPLOAD_BOTTOMLEFTBUTTONAPPROVED]];
	}
	else {
		[helper setText:_lblApprovalStatus textName:[RWTEXT REDUPLOAD_APPROVALSTATUSNO] defaultText:[RWDEFAULTTEXT REDUPLOAD_APPROVALSTATUSNO]];
		[helper setButtonText:_btnBottomLeft textName:[RWTEXT REDUPLOAD_BOTTOMLEFTBUTTONUNAPPROVED] defaultText:[RWDEFAULTTEXT REDUPLOAD_BOTTOMLEFTBUTTONUNAPPROVED]];
	}
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	if(_imagePath){
        UIImage *image = [UIImage imageWithContentsOfFile:_imagePath];
        [_imgPicture setImage:image];
		
		//		float aspect = image.size.height/image.size.width;
		//		[_imgPicture addConstraint:[NSLayoutConstraint constraintWithItem:_imgPicture attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imgPicture attribute:NSLayoutAttributeWidth multiplier:aspect constant:0]];
		
    }
}

- (IBAction)textFieldChanged:(id)sender{
	_redUploadImageObject.text = _txtPictureText.text;
	[self saveDatabaseChange:@"Error when saving the changed text"];
}

- (IBAction)backButtonClicked:(id)sender{
	if ([_page hasChild:[RWPAGE POPTWICE]] && [_page getBoolFromNode:[RWPAGE POPTWICE]]) {
		[_app.navController popTwoPages];
	}
	else {
		[_app.navController popPage];
	}
}

- (IBAction)topRightButtonClicked:(id)sender{
	RWXmlNode *cameraPage = [[_xml getPage:[_page getStringFromNode:[RWPAGE CHILD]]] deepClone];
	
	[cameraPage addNodeWithName:[RWPAGE REDUPLOADFOLDERID] value:_folder.folderId];
	
	[_app.navController pushViewWithPage:cameraPage];
}

- (IBAction)bottomLeftButtonClicked:(id)sender{
	
	if (!_redUploadImageObject.approved) {
        RWTextHelper *helper = _textHelper;
		[_swcApproval setOn:YES animated:YES];
		[helper setText:_lblApprovalStatus textName:[RWTEXT REDUPLOAD_APPROVALSTATUSYES] defaultText:[RWDEFAULTTEXT REDUPLOAD_APPROVALSTATUSYES]];
		[helper setButtonText:_btnBottomLeft textName:[RWTEXT REDUPLOAD_BOTTOMLEFTBUTTONAPPROVED] defaultText:[RWDEFAULTTEXT REDUPLOAD_BOTTOMLEFTBUTTONAPPROVED]];
		
		[_redUploadImageObject setApproved:[NSNumber numberWithBool:YES]];
		
		[self saveDatabaseChange:@"Error when saving approved status"];
    } else {
        
    }
}

- (IBAction)deletePictureButtonClicked:(id)sender{
	
	NSString *filePath = [_page getStringFromNode:[RWPAGE FILEPATH]];
	
	[_db.RedUploadImages deleteEntryWithImagePath:filePath];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager removeItemAtPath:filePath error:nil];
	
	[self backButtonClicked:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveDatabaseChange:(NSString *)errorMessage{
	NSError *error = nil;
	bool success = [_app.managedObjectContext save:&error];
	if (!success) {
		DDLogError(errorMessage, error);
	}
}

@end
