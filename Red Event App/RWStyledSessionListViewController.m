//
//  RWStyledSessionListViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 1/13/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+RWViewLayout.h"

#import "RWStyledSessionListViewController.h"
#import "RWStyledSessionListItem.h"

#import "RWSessionVM.h"

#import "RWXmlNode.h"
#import "RWAppearanceHelper.h"
#import "RWPAGE.h"

@interface RWStyledSessionListViewController ()

@end

@implementation RWStyledSessionListViewController{
    NSArray *dataSource;
}


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWStyledSessionListViewController" bundle:nil page:page];
    if (self) {
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//TODO: Hacks!!!! Tableview doesn't call numberOfRowsInSection if TranslatesAutoresizingMaskIntoConstraints is set to NO, and the page is in a swipeview. The below if construct "solves" that problem.
	if(![_xml swipeViewHasPage:_page]){
		[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	
	dataSource = [_db.Sessions getVMListFilteredByDate:[_db.Sessions getLastDateTimeByVenue:-1] venueid:-1];
	
	[self setAppearance];
	[self setText];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    [_lstSessions reloadData];
	[self setTableHeight];
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAppearance{
	RWAppearanceHelper *helper = _appearanceHelper;

    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	_vwTableBackground.layer.cornerRadius = 5;
	_vwTableBackground.layer.masksToBounds = YES;

    [helper setBackgroundColor:_vwTableBackground localName:[RWLOOK STYLEDSESSIONLIST_LISTBACKGROUNDCOLOR]  globalName:[RWLOOK DEFAULT_ALTCOLOR]];

    [helper.label setTitleStyle:_lblTitle];

	[helper setBorderColor:_vwTableBackground localName:[RWLOOK STYLEDSESSIONLIST_LISTLINECOLOR] globalName:[RWLOOK DEFAULT_ALTTEXTCOLOR]];
	_vwTableBackground.layer.borderWidth = 2.0f;
}

- (void)setText{
	RWTextHelper *helper = _textHelper;
	
	[helper setText:_lblTitle textName:[RWTEXT STYLEDSESSIONLIST_TITLE] defaultText:[RWDEFAULTTEXT STYLEDSESSIONLIST_TITLE]];
}

#pragma mark - Table view layout

- (void)setTableHeight{
	[_lstSessions layoutIfNeeded];
	CGSize tableViewSize = _lstSessions.contentSize;
	[_lstSessions RWsetHeightAsConstraint:tableViewSize.height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	RWStyledSessionListItem *cell = [tableView dequeueReusableCellWithIdentifier:@"RWStyledSessionListItem"];
    
	if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWStyledSessionListItem" owner:self options:nil];
		cell = [nib objectAtIndex:0];
		[cell initializeCellWithParentPage:_page];
    }
	
	[cell setupCellWithRow:indexPath.row dataSource:dataSource];
	
	cell.lblBody.preferredMaxLayoutWidth = CGRectGetWidth(tableView.frame);
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
	
	[cell setNeedsLayout];
	[cell layoutIfNeeded];
	
	CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
	
	height += 1.0f;
	
	return height;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWStyledSessionListItem";
    RWStyledSessionListItem *cell = (RWStyledSessionListItem *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWStyledSessionListItem" owner:self options:nil];
		cell = [nib objectAtIndex:0];
		[cell initializeCellWithParentPage:_page];
    }
	
	[cell setupCellWithRow:indexPath.row dataSource:dataSource];
	
    return cell;
}

@end
