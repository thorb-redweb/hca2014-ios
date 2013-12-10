//
//  RWImageUploadBrowserViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 12/10/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(![_xml swipeViewHasPage:_page]){
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderName = [_page getStringFromNode:[RWPAGE FOLDER]];
    NSString *folderPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:folderName];
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:NULL];

    pathList = [[NSMutableArray alloc] init];
    for(NSString *file in fileList){
        NSString *path = [folderPath stringByAppendingPathComponent:file];
        [pathList addObject:path];
    }
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
    }

    NSString *filePath = [pathList objectAtIndex:indexPath.row];

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *folderName = [_page getStringFromNode:[RWPAGE FOLDER]];
//    NSString *folderPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:folderName];
//    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];

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
@end
