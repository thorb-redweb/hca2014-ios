//
//  RWHcaSplitView.m
//  Red App
//
//  Created by Thorbjørn Steen on 2/25/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"
#import "RWHcaSplitView.h"
#import "RWHcaListCell.h"
#import "RWSessionVM.h"

@implementation RWHcaSplitView{
	NSString *cellIdentifier;
	NSArray *_sessions;
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWHcaSplitView" bundle:nil page:page];
    if (self) {
		cellIdentifier = @"hcalistcell";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	_sessions = [_db.Sessions getNextThreeVMs:[[NSDate alloc] init]];
	
	NSString *childname2 = [_page getStringFromNode:[RWPAGE CHILD2]];
	NSMutableArray *newsCells = [[NSMutableArray alloc] initWithObjects:_nwsCell1, _nwsCell2, _nwsCell3, nil];
	NSArray *catIds = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:9],[NSNumber numberWithInt:30],[NSNumber numberWithInt:31],[NSNumber numberWithInt:34], nil];
	[_nwsTicker initializeWithDatasource:[[NSMutableArray alloc] initWithArray:[_db.Articles getVMListOfLastThree:catIds]] newsCells:newsCells app:_app childname:childname2];
	
    [self setAppearance];
	[self setText];
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[_nwsTicker startPaging];
}

- (void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	[_nwsTicker stopPaging];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
}

-(void)setText{
}

#pragma mark - Table view layout

- (void)setTableHeight{
	[_lstSessions layoutIfNeeded];
	CGSize tableViewSize = _lstSessions.contentSize;
	[_lstSessions RWsetHeightAsConstraint:tableViewSize.height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 48;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  _sessions.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	RWSessionVM *model = _sessions[indexPath.row];
	
	CGSize contentSize = _nwsTicker.contentSize;
	if(contentSize.width == 0){}
	
	RWXmlNode *childPage = [[_xml getPage:_childname] deepClone];
	[childPage addNodeWithName:[RWPAGE SESSIONID] value:model.sessionid];
	
    [_app.navController pushViewWithPage:childPage];
	
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
    cell = [self setupCell:cell tableView:tableView cellForRowAtIndexPath:indexPath];
	
    return cell;
}

- (UITableViewCell *)setupCell:(UITableViewCell *)cell tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	RWHcaListCell *hcaCell = (RWHcaListCell *)cell;
	if (hcaCell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWHcaListCell" owner:self options:nil];
		hcaCell = [nib objectAtIndex:0];
	}
	[hcaCell initializeCellWithParentPage:_page];
	
	[hcaCell setupCellWithRow:indexPath.row dataSource:_sessions];
	return hcaCell;
}
@end
