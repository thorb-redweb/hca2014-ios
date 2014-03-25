//
//  RWDailySessionListViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//
#import "NSDate+RWDate.h"
#import "NSString+RWString.h"
#import "UIView+RWViewLayout.h"

#import "RWDailySessionListViewController.h"
#import "RWFilterTableController.h"

#import "RWAppDelegate.h"
#import "RWDbInterface.h"

#import	"RWSessionDetailViewController.h"
#import "RWDailySessionListItem.h"

#import "RWSessionVM.h"
#import "RWAppearanceHelper.h"
#import "RWTextHelper.h"
#import "RWTEXT.h"
#import "RWDEFAULTTEXT.h"


@interface RWDailySessionListViewController ()

@end

@implementation RWDailySessionListViewController {
    NSArray *dataSource;

    NSDate *_listDate;

    int changeDateDirection; //positive for forward, negative for back
	
	RWFilterTableController *_typeTableController;
	RWFilterTableController *_venueTableController;
	
	NSString *standardTypeFilterTitle;
	NSString *standardVenueFilterTitle;
}


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWDailySessionListViewController" bundle:nil page:page];
    if (self) {
		standardTypeFilterTitle = @"Sorter på type";
		standardVenueFilterTitle = @"Sorter på sted";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	//TODO: Hacks!!!! Tableview doesn't call numberOfRowsInSection if TranslatesAutoresizingMaskIntoConstraints is set to NO, and the page is in a swipeview. The below if construct "solves" that problem.
	if(![_xml swipeViewHasPage:_page]){
		[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	
	_btnTypePicker.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	_btnTypePicker.titleLabel.textAlignment = NSTextAlignmentCenter;
	_btnTypePicker.titleEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
	[_btnTypePicker setTitle:standardTypeFilterTitle forState:UIControlStateNormal];
	_btnVenuePicker.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	_btnVenuePicker.titleLabel.textAlignment = NSTextAlignmentCenter;
	_btnVenuePicker.titleEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
	[_btnVenuePicker setTitle:standardVenueFilterTitle forState:UIControlStateNormal];
	
	NSArray *typeSource = [[NSArray alloc] initWithObjects:@"Alle", @"Underholdning og teater", @"Leg og læring", @"Musik", @"Kulturformidling", @"Kunst og kultur", @"Spoken Word",nil];
	_typeTableController = [[RWFilterTableController alloc] initWithDatasource:typeSource defaultName:@"Alle"];

	NSArray *venueSource = [_db.Venues getNamesAndInsertAtFirstPosition:@"Alle"];
	_venueTableController = [[RWFilterTableController alloc] initWithDatasource:venueSource defaultName:@"Alle"];

    _listDate = [_db.Sessions getStartDateTimeWithSessionByDateTime:[NSDate date] venueid:[self filterVenueId] type:_typeTableController.getSelectedName];
	
	if(_listDate == nil){
		_listDate = [NSDate date];
	}
	
	[self setAppearance];
	[self setText];

    [self upDateSessionList];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
    [helper setBackgroundColor:_lstTableView localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.button setBackgroundImageFromLocalSource:_btnPrevious localName:[RWLOOK DAILYSESSIONLIST_LEFTARROW]];
    [helper.button setBackgroundImageFromLocalSource:_btnNext localName:[RWLOOK DAILYSESSIONLIST_RIGHTARROW]];

    [helper.label setColor:_lblDate localName:[RWLOOK DAILYSESSIONLIST_DATETEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFontForLast:[RWLOOK DAILYSESSIONLIST_DATETEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
           localStyleName:[RWLOOK DAILYSESSIONLIST_DATETEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
    [helper.label setShadowColorForLast:[RWLOOK DAILYSESSIONLIST_DATETEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffsetForLast:[RWLOOK DAILYSESSIONLIST_DATETEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];

    [helper.button setButtonStyle:_btnTypePicker];
    [helper.button setButtonStyle:_btnVenuePicker];
	
	[helper setScrollBounces:_lstTableView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblDate textName:[RWTEXT DAILYSESSIONLIST_FILTERDATE] defaultText:[RWDEFAULTTEXT DAILYSESSIONLIST_FILTERDATE]];
}

- (void)upDateSessionList {	
    dataSource = [_db.Sessions getVMListFilteredByDate:_listDate venueid:[self filterVenueId] type:_typeTableController.getSelectedName];
	if(dataSource.count == 0){
		NSDate *dateWithSession;
		dateWithSession = [_db.Sessions getNextDateTimeByDateTime:[_listDate endOfDay] venueid:[self filterVenueId] type:_typeTableController.getSelectedName];
		if(dateWithSession == NULL){
			dateWithSession = [_db.Sessions getPreviousDateTimeByDateTime:[_listDate endOfDay] venueid:[self filterVenueId] type:_typeTableController.getSelectedName];
		}
		if (dateWithSession != NULL) {
			_listDate = dateWithSession;
			[self upDateSessionList];
		}
		else{
			_btnNext.hidden = YES;
			_btnPrevious.hidden = YES;
			[_lstTableView reloadData];
			return;
		}
	}
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE d MMM"];
    _lblDate.text = [dateFormatter stringFromDate:_listDate];
    [self reloadView];
}

- (void)reloadView {
    if ([self isYesterdayBeforeFirstSession]) {
        _btnPrevious.hidden = YES;
    }
    else {
        _btnPrevious.hidden = NO;
    }
    if ([self isTomorrowAfterLastSession]) {
        _btnNext.hidden = YES;
    }
    else {
        _btnNext.hidden = NO;
    }
    [_lstTableView reloadData];
}

- (BOOL)isYesterdayBeforeFirstSession {
    NSDate *firstSessionDate = [[_db.Sessions getFirstDateTimeByVenue:[self filterVenueId] type:_typeTableController.getSelectedName] roundToDate];
    NSDate *yesterDay = [[_listDate dateByAddingTimeInterval:-86400] roundToDate];
    return [firstSessionDate compare:yesterDay] == NSOrderedDescending;
}

- (BOOL)isTomorrowAfterLastSession {
    NSDate *lastSessionDate = [[_db.Sessions getLastDateTimeByVenue:[self filterVenueId] type:_typeTableController.getSelectedName] roundToDate];
    NSDate *tomorrowDay = [[_listDate dateByAddingTimeInterval:86400] roundToDate];
    return [lastSessionDate compare:tomorrowDay] == NSOrderedAscending;
}

- (int)filterVenueId {
    if ([_venueTableController.getSelectedName isEqualToString:@"Alle"]) {
        return -1;
    }
    else {
        return [_db.Venues getIdFromName:_venueTableController.getSelectedName];
    }
}

- (IBAction)previousDay:(id)sender {
    _listDate = [_db.Sessions getPreviousDateTimeByDateTime:[_listDate roundToDate] venueid:[self filterVenueId] type:_typeTableController.getSelectedName];
    [self upDateSessionList];
}

- (IBAction)nextDay:(id)sender {
	_listDate = [_db.Sessions getNextDateTimeByDateTime:[_listDate endOfDay] venueid:[self filterVenueId] type:_typeTableController.getSelectedName];
    [self upDateSessionList];
}

- (IBAction)openTypePickingView:(id)sender {
	UIAlertView *typePicker = [[UIAlertView alloc] initWithTitle:@"Sorter på type" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	typePicker.tag = 1;
	
	UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(15, 0, 280, 290) style:UITableViewStylePlain];
	tableview.delegate = _typeTableController;
	tableview.dataSource = _typeTableController;
	tableview.backgroundColor = [UIColor clearColor];
	
	[typePicker setValue:tableview forKey:@"accessoryView"];
	[typePicker show];
}

- (IBAction)openVenuePickingView:(id)sender {
    UIAlertView *venuePicker = [[UIAlertView alloc] initWithTitle:@"Sorter på sted" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	venuePicker.tag = 2;
	
	UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(15, 0, 280, 290) style:UITableViewStylePlain];
	tableview.delegate = _venueTableController;
	tableview.dataSource = _venueTableController;
	tableview.backgroundColor = [UIColor clearColor];
	
	[venuePicker setValue:tableview forKey:@"accessoryView"];
	[venuePicker show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(alertView.tag == 1){
		NSString *type = [_typeTableController getSelectedName];
		if([type isEqualToString:@"Alle"]){
			type = standardTypeFilterTitle;
		}
		[_btnTypePicker setTitle:type forState:UIControlStateNormal];
	}
	else if(alertView.tag == 2){
		NSString *venue = [_venueTableController getSelectedName];
		if([venue isEqualToString:@"Alle"]){
			venue = standardVenueFilterTitle;
		}
		[_btnVenuePicker setTitle:venue forState:UIControlStateNormal];
	}
	[self upDateSessionList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RWSessionVM *model = dataSource[indexPath.row];

    RWXmlNode *nextPage = [[_xml getPage:_childname] deepClone];
    [nextPage addNodeWithName:[RWPAGE SESSIONID] value:model.sessionid];

    [_app.navController pushViewWithPage:nextPage];
	
	[_lstTableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWDailySessionListItem";
    RWDailySessionListItem *cell = (RWDailySessionListItem *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWDailySessionListItem" owner:self options:nil];
        cell = [nib objectAtIndex:0];
		[self setCellAppearance:cell];
    }

    RWSessionVM *viewmodel = [dataSource objectAtIndex:indexPath.row];
    cell.lblTimeAndPlace.text = [NSString stringWithFormat:@"%@-%@ - %@", viewmodel.startTime, viewmodel.endTime, viewmodel.venue];
    cell.lblEvent.text = viewmodel.title;
	cell.lblType.text = viewmodel.type;
	cell.lblType.textColor = viewmodel.typeColor;
	cell.imgType.image = viewmodel.typeIcon;
	cell.vwRightBorder.backgroundColor = viewmodel.typeColor;

    return cell;
}

- (void)setCellAppearance:(RWDailySessionListItem *)cell{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:cell localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.label setBackTextStyle:cell.lblTimeAndPlace];
    [helper.label setBackTextStyle:cell.lblEvent];
    [helper.label setBackTextStyle:cell.lblType];
}

@end
