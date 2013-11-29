//
//  RWUpcomingSessionsDelegate.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWUpcomingSessionsDelegate.h"

#import "RWAppDelegate.h"

#import "RWUpcomingSessionsListItem.h"
#import "RWSessionVM.h"
#import "RWDbSessions.h"
#import "RWXMLStore.h"
#import "RWXmlNode.h"
#import "RWAppearanceHelper.h"
#import "RWLOOK.h"
#import "RWPAGE.h"



@implementation RWUpcomingSessionsDelegate {
    RWAppDelegate *_app;
    RWDbInterface *_db;
	RWXMLStore *_xml;

    NSArray *dataSource;
	NSString *_name;
    NSString *_childname;
}

- (id)initWithPage:(RWXmlNode *)page {
    self = [super init];

    if (self) {
		_name = [page getStringFromNode:[RWPAGE NAME]];
        _childname = [page getStringFromNode:[RWPAGE CHILD]];

        _app = [[UIApplication sharedApplication] delegate];
        _db = _app.db;
		_xml = _app.xml;
        dataSource = [_db.Sessions getNextThreeVMs:[[NSDate alloc] init]];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWUpcomingSessionsListItem";
    RWUpcomingSessionsListItem *cell = (RWUpcomingSessionsListItem *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWUpcomingSessionsListItem" owner:self options:nil];
        cell = [nib objectAtIndex:0];
		[self setCellAppearance:cell];
    }	

    RWSessionVM *viewmodel = [dataSource objectAtIndex:indexPath.row];
    if (viewmodel.hasTime) {
        cell.lblDateTime.text = [NSString stringWithFormat:@"kl. %@ - %@, %@", viewmodel.startTime, viewmodel.endTime, viewmodel.startDateShort];
    }
    else {
        cell.lblDateTime.text = [NSString stringWithFormat:@"%@", viewmodel.startDateShort];
    }
    cell.lblEventAndPlace.text = [NSString stringWithFormat:@"%@ v/ %@", viewmodel.title, viewmodel.venue];

    return cell;
}

-(void)setCellAppearance:(RWUpcomingSessionsListItem *)cell{
	RWXmlNode *localLook = [_xml getAppearanceForPage:_name];
	RWXmlNode *globalLook = [_xml getAppearanceForPage:[RWLOOK DEFAULT]];
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];
	
	[helper setBackgroundColor:cell localName:[RWLOOK UPCOMINGSESSIONS_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	NSArray *labelArray = [NSArray arrayWithObjects:cell.lblDateTime, cell.lblEventAndPlace, nil];
	
	[helper setLabelColors:labelArray localName:[RWLOOK UPCOMINGSESSIONS_TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
	[helper setLabelFonts:labelArray localSizeName:[RWLOOK UPCOMINGSESSIONS_TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE] localStyleName:[RWLOOK UPCOMINGSESSIONS_TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
	[helper setLabelShadowColors:labelArray localName:[RWLOOK UPCOMINGSESSIONS_TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffsets:labelArray localName:[RWLOOK UPCOMINGSESSIONS_TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    RWSessionVM *model = dataSource[indexPath.row];
//
//    NSMutableDictionary *sessiondetailVariables = [[NSMutableDictionary alloc] init];
//    [sessiondetailVariables setObject:@"SessionDetail" forKey:@"type"];
//    [sessiondetailVariables setObject:_childname forKey:@"name"];
//    [sessiondetailVariables setObject:model.sessionid forKey:@"sessionid"];
//
//    [_app.navController pushViewWithParameters:sessiondetailVariables];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

@end
