//
//  RWDailySessionListViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/28/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//
#import "NSDate+RWDate.h"
#import "NSString+RWString.h"

#import "RWDailySessionListViewController.h"

#import "RWAppDelegate.h"
#import "RWDbInterface.h"

#import	"RWSessionDetailViewController.h"
#import "RWVenuePickerViewController.h"
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
}


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWDailySessionListViewController" bundle:nil page:page];
    if (self) {
		
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	//TODO: Hacks!!!! Tableview doesn't call numberOfRowsInSection if TranslatesAutoresizingMaskIntoConstraints is set to NO, and the page is in a swipeview. The below if construct "solves" that problem.
	if(![_xml swipeViewHasPage:_page]){
		[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	

    _listDate = [_db.Sessions getStartDateTimeWithSessionByDateTime:[NSDate date] venueid:[self filterVenueId]];
	
	[self setAppearance];
	[self setText];

    [self upDateSessionList];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
    [helper setBackgroundColor:[self tableView] localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper setButtonBackgroundImageFromLocalSource:_btnPrevious localName:[RWLOOK DAILYSESSIONLIST_LEFTARROW] forState:UIControlStateNormal];
    [helper setButtonBackgroundImageFromLocalSource:_btnNext localName:[RWLOOK DAILYSESSIONLIST_RIGHTARROW] forState:UIControlStateNormal];

    [helper setLabelColor:_lblDate localName:[RWLOOK DAILYSESSIONLIST_DATETEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:_lblDate localSizeName:[RWLOOK DAILYSESSIONLIST_DATETEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE]
          localStyleName:[RWLOOK DAILYSESSIONLIST_DATETEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
	[helper setLabelShadowColor:_lblDate localName:[RWLOOK DAILYSESSIONLIST_DATETEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:_lblDate localName:[RWLOOK DAILYSESSIONLIST_DATETEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];

    [helper setBackgroundColor:_viewDateUnderline localName:[RWLOOK DAILYSESSIONLIST_DATEUNDERLINECOLOR] globalName:[RWLOOK DEFAULT_ALTCOLOR]];

    [helper setButtonTitleColor:_btnVenuePicker forState:UIControlStateNormal localName:[RWLOOK DAILYSESSIONLIST_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setButtonTitleFont:_btnVenuePicker forState:UIControlStateNormal localSizeName:[RWLOOK DAILYSESSIONLIST_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
                localStyleName:[RWLOOK DAILYSESSIONLIST_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setButtonTitleShadowColor:_btnVenuePicker forState:UIControlStateNormal localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setButtonTitleShadowOffset:_btnVenuePicker forState:UIControlStateNormal localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblDate textName:[RWTEXT DAILYSESSIONLIST_FILTERDATE] defaultText:[RWDEFAULTTEXT DAILYSESSIONLIST_FILTERDATE]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (_filterVenue == nil) {
        [_btnVenuePicker setTitle:@"Filtrer efter sted" forState:UIControlStateNormal];
    }
    else {
        [_btnVenuePicker setTitle:_filterVenue.title forState:UIControlStateNormal];
    }
	
	_listDate = [_db.Sessions getStartDateTimeWithSessionByDateTime:_listDate venueid:[self filterVenueId]];
    [self upDateSessionList];
}

- (void)upDateSessionList {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE d MMM"];
    _lblDate.text = [dateFormatter stringFromDate:_listDate];

    dataSource = [_db.Sessions getVMListFilteredByDate:_listDate venueid:[self filterVenueId]];

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
    [_tableView reloadData];
}

- (BOOL)isYesterdayBeforeFirstSession {
    NSDate *firstSessionDate = [[_db.Sessions getFirstDateTimeByVenue:[self filterVenueId]] roundToDate];
    NSDate *yesterDay = [[_listDate dateByAddingTimeInterval:-86400] roundToDate];
    return [firstSessionDate compare:yesterDay] == NSOrderedDescending;
}

- (BOOL)isTomorrowAfterLastSession {
    NSDate *lastSessionDate = [[_db.Sessions getLastDateTimeByVenue:[self filterVenueId]] roundToDate];
    NSDate *tomorrowDay = [[_listDate dateByAddingTimeInterval:86400] roundToDate];
    return [lastSessionDate compare:tomorrowDay] == NSOrderedAscending;
}

- (int)filterVenueId {
    if (_filterVenue == nil) {
        return -1;
    }
    else {
        return _filterVenue.venueid;
    }
}

- (IBAction)previousDay:(id)sender {
    _listDate = [_db.Sessions getPreviousDateTimeByDateTime:_listDate venueid:[self filterVenueId]];
    [self upDateSessionList];
}

- (IBAction)nextDay:(id)sender {
	_listDate = [_db.Sessions getNextDateTimeByDateTime:_listDate venueid:[self filterVenueId]];
    [self upDateSessionList];
}

- (IBAction)openVenuePickingView:(id)sender {
    RWVenuePickerViewController *controller = [[RWVenuePickerViewController alloc] initWithController:self page:_page];
    [_app.navController pushViewController:controller addToBackStack:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RWSessionVM *model = dataSource[indexPath.row];

    RWXmlNode *nextPage = [_xml getPage:_childname];
    [nextPage addNodeWithName:[RWPAGE SESSIONID] value:model.sessionid];

    [_app.navController pushViewWithPage:nextPage];
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

    return cell;
}

- (void)setCellAppearance:(RWDailySessionListItem *)cell{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:cell localName:[RWLOOK DAILYSESSIONLIST_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper setLabelColor:cell.lblTimeAndPlace localName:[RWLOOK DAILYSESSIONLIST_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:cell.lblTimeAndPlace localSizeName:[RWLOOK DAILYSESSIONLIST_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
          localStyleName:[RWLOOK DAILYSESSIONLIST_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setLabelShadowColor:cell.lblTimeAndPlace localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:cell.lblTimeAndPlace localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];

    [helper setLabelColor:cell.lblEvent localName:[RWLOOK DAILYSESSIONLIST_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:cell.lblEvent localSizeName:[RWLOOK DAILYSESSIONLIST_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
          localStyleName:[RWLOOK DAILYSESSIONLIST_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper setLabelShadowColor:cell.lblEvent localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:cell.lblEvent localName:[RWLOOK DAILYSESSIONLIST_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}

@end
