//
//  RWPushMessageListViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWPushMessageListViewController.h"
#import "RWPushMessageListCell.h"
#import "RWPushMessageVM.h"
#import "RWArticleVM.h"
#import "RWDbPushMessages.h"
#import "RWDbPushMessageGroups.h"

@interface RWPushMessageListViewController ()

@end

@implementation RWPushMessageListViewController{
    NSArray *_dataSource;
}

- (id)initWithPage:(RWXmlNode *)page
{
    self = [super initWithNibName:nil bundle:nil page:page];
    if (self) {
        // Custom initialization
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
	
	if([_page hasChild:[RWPAGE PUSHGROUPIDS]] && [_page hasChild:[RWPAGE SUBSCRIPTIONS]] && [_page getBoolFromNode:[RWPAGE SUBSCRIPTIONS]])
    {
        _dataSource = [_db.PushMessages getVMListFromGroupIds:[_page getNSNumberArrayFromNode:[RWPAGE PUSHGROUPIDS]]];
    } else if([_page hasChild:[RWPAGE PUSHGROUPIDS]])
    {
        _dataSource = [_db.PushMessages getVMListFromGroupIds:[_page getNSNumberArrayFromNode:[RWPAGE PUSHGROUPIDS]]];
    } else {
        _dataSource = [_db.PushMessages getVMListFromSubscribedGroups];
    }

    [self setAppearance];
}

-(void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundTileImageOrColor:_lstTableView localImageName:[RWLOOK BACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper setScrollBounces:_lstTableView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RWPushMessageVM *model = _dataSource[indexPath.row];

    RWXmlNode *childPage = [_xml getPage:_childname];
    [childPage addNodeWithName:[RWPAGE PUSHMESSAGEID] value:model.pushmessageid];

    [_app.navController pushViewWithPage:childPage];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWPushMessageListCell";
    RWPushMessageListCell *cell = (RWPushMessageListCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWPushMessageListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [self setCellAppearance:cell];
    }

    RWPushMessageVM *viewmodel = [_dataSource objectAtIndex:indexPath.row];
    cell.lblTitle.text = viewmodel.intro;
    cell.lblBody.text = [viewmodel senddateWithPattern:@"yyyy-MM-dd"];

    return cell;
}

- (void)setCellAppearance:(RWPushMessageListCell *)cell{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:cell localName:[RWLOOK CELLBACKGROUNDCOLOR] globalName:[RWLOOK INVISIBLE]];

    [helper.label setColor:cell.lblTitle localName:[RWLOOK ITEMTITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:cell.lblTitle localSizeName:[RWLOOK ITEMTITLESIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
           localStyleName:[RWLOOK ITEMTITLESTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper.label setShadowColor:cell.lblTitle localName:[RWLOOK ITEMTITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:cell.lblTitle localName:[RWLOOK ITEMTITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];

    [helper.label setColor:cell.lblBody localName:[RWLOOK TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper.label setFont:cell.lblBody localSizeName:[RWLOOK TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_TEXTSIZE]
           localStyleName:[RWLOOK TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_TEXTSTYLE]];
    [helper.label setShadowColor:cell.lblBody localName:[RWLOOK TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper.label setShadowOffset:cell.lblBody localName:[RWLOOK TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_TEXTSHADOWOFFSET]];
}

@end
