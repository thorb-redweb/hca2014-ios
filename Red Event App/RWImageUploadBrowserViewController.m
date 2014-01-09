//
//  RWImageUploadBrowserViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 12/10/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIColor+RWColor.h"

#import "RWImageUploadBrowserViewController.h"
#import "RWImageUploadBrowserListItem.h"

@interface RWImageUploadBrowserViewController ()

@end

@implementation RWImageUploadBrowserViewController {
    NSMutableArray *pathList;
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWImageUploadBrowserViewController" bundle:nil page:page];
    if (self) {
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderName = [_page getStringFromNode:[RWPAGE FOLDER]];
    NSString *folderPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:folderName];
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:NULL];
	
    pathList = [[NSMutableArray alloc] init];
    for(int j = fileList.count-1; j >= 0; j--){
        NSString *file = fileList[j];
        NSString *path = [folderPath stringByAppendingPathComponent:file];
        [pathList addObject:path];
    }

    [self setAppearance];
}

-(void)setAppearance{
    RWAppearanceHelper *helper = _appearanceHelper;

    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[_lstImageFiles setBackgroundColor:[UIColor colorWithHexString:@"00000000"]];

	[helper setScrollBounces:_lstImageFiles localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fileName = [pathList objectAtIndex:indexPath.row];
	
	RWXmlNode *parentPage = (RWXmlNode *)[_page getChildFromNode:[RWPAGE PARENTPAGE]].value;
	if([parentPage hasChild:[RWPAGE FILEPATH]]){
		[[parentPage getChildFromNode:[RWPAGE FILEPATH]] setValue:fileName];
	}
	else {
		[parentPage addNodeWithName:[RWPAGE FILEPATH] value:fileName];
	}
	
	[_app.navController popPage];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if(editingStyle == UITableViewCellEditingStyleDelete){
		[pathList removeObjectAtIndex:indexPath.row];
		[_lstImageFiles deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		NSString *filePath = pathList[indexPath.row];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager removeItemAtPath:filePath error:nil];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return pathList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWImageUploadBrowserListItem";
    RWImageUploadBrowserListItem *cell = (RWImageUploadBrowserListItem *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWImageUploadBrowserListItem" owner:self options:nil];
        cell = [nib objectAtIndex:0];
		[self setCellAppearance:cell];
    }
	
    NSString *filePath = [pathList objectAtIndex:indexPath.row];
	
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    [cell.imgImageItem setImage: image];
	
    NSArray *seperatedPath = [filePath componentsSeparatedByString:@"/"];
    NSString *fileName = seperatedPath[seperatedPath.count-1];
    NSArray *seperateDateAndTime = [fileName componentsSeparatedByString:@"_"];
    NSArray *splittedDate = [seperateDateAndTime[0] componentsSeparatedByString:@"-"];
    NSArray *splittedTime = [seperateDateAndTime[1] componentsSeparatedByString:@"-"];
    NSString *dateString = [NSString stringWithFormat:@"%@/%@/%@",splittedDate[0],splittedDate[1],splittedDate[2]];
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@",splittedTime[0],splittedTime[1],splittedTime[2]];
    NSString *formatedFileName = [NSString stringWithFormat:@"%@\n%@",dateString,timeString];
	
    cell.lblFilePath.text = formatedFileName;
	
    return cell;
}

- (void)setCellAppearance:(RWImageUploadBrowserListItem *)cell{
    RWAppearanceHelper *helper = _appearanceHelper;
	
    [helper setBackgroundColor:cell localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK INVISIBLE]];
	
    [helper setLabelColor:cell.lblFilePath localName:[RWLOOK ITEMTITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:cell.lblFilePath localSizeName:[RWLOOK ITEMTITLESIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
          localStyleName:[RWLOOK ITEMTITLESTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setLabelShadowColor:cell.lblFilePath localName:[RWLOOK ITEMTITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:cell.lblFilePath localName:[RWLOOK ITEMTITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
	
//    [helper setLabelColor:cell.lblFilePath localName:[RWLOOK IMAGEARTICLELIST_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
//    [helper setLabelFont:cell.lblFilePath localSizeName:[RWLOOK IMAGEARTICLELIST_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
//          localStyleName:[RWLOOK IMAGEARTICLELIST_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
//    [helper setLabelShadowColor:cell.lblFilePath localName:[RWLOOK IMAGEARTICLELIST_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
//    [helper setLabelShadowOffset:cell.lblFilePath localName:[RWLOOK IMAGEARTICLELIST_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}
@end
