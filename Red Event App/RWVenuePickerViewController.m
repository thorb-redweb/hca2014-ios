//
//  RWVenuePickerViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWVenuePickerViewController.h"

#import "RWAppDelegate.h"
#import "RWDbInterface.h"

#import "RWVenueVM.h"
#import "RWAppearanceHelper.h"

@interface RWVenuePickerViewController ()

@end

@implementation RWVenuePickerViewController {
    RWAppDelegate *_app;
    RWDbInterface *_db;
    RWXMLStore *_xml;

    NSArray *dataSource;

    RWDailySessionListViewController *_controller;
    RWNode *_page;
}

- (id)initWithController:(RWDailySessionListViewController *)controller page:(RWNode *)page{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _app = [[UIApplication sharedApplication] delegate];
        _db = _app.db;
        _xml = _app.xml;
        _controller = controller;
        _page = page;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.clearsSelectionOnViewWillAppear = NO;
    dataSource = [_db.Venues getVMList];

    [self setAppearance];
}

- (void)setAppearance{
    RWNode *localLook = [_xml.appearance getChildFromNode:[_page getStringFromNode:[RWPAGE NAME]]];
    RWNode *globalLook = [_xml.appearance getChildFromNode:[RWLOOK GLOBAL]];
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];

    [helper setBackgroundColor:[self tableView] localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK GLOBAL_BACKCOLOR]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    [self setAppearance:cell];

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Alle";
    }
    else {
        cell.textLabel.text = ((RWVenueVM *) dataSource[indexPath.row - 1]).title;
    }

    return cell;
}

- (void)setAppearance:(UITableViewCell *)cell{
    RWNode *localLook = [_xml.appearance getChildFromNode:[_page getStringFromNode:[RWPAGE NAME]]];
    RWNode *globalLook = [_xml.appearance getChildFromNode:[RWLOOK GLOBAL]];
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];

    [helper setBackgroundColor:cell localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK GLOBAL_BACKCOLOR]];

    [helper setLabelColor:cell.textLabel localName:[RWLOOK DAILYSESSIONLIST_TEXTCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTCOLOR]];
    [helper setLabelFont:cell.textLabel localSizeName:[RWLOOK DAILYSESSIONLIST_TEXTSIZE] globalSizeName:[RWLOOK GLOBAL_TEXTSIZE]
          localStyleName:[RWLOOK DAILYSESSIONLIST_TEXTSTYLE] globalStyleName:[RWLOOK GLOBAL_TEXTSTYLE]];
    [helper setLabelShadowColor:cell.textLabel localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWCOLOR] globalName:[RWLOOK GLOBAL_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:cell.textLabel localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWOFFSET] globalName:[RWLOOK GLOBAL_TEXTSHADOWOFFSET]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataSource.count + 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _controller.filterVenue = nil;
    }
    else {
        _controller.filterVenue = ((RWVenueVM *) dataSource[indexPath.row - 1]);
    }

    [_app.navController popViewController];
}

@end
