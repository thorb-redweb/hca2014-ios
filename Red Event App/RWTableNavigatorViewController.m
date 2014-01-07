//
//  RWTableNavigatorViewController.m
//  Red App
//
//  Created by Thorbjørn Steen on 11/20/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIColor+RWColor.h"

#import "RWTableNavigatorViewController.h"
#import "RWTableNavigatorCell.h"
#import "UIImageView+WebCache.h"

@implementation RWTableNavigatorViewController {
    NSArray *dataSource;
}


- (id)initWithPage:(RWXmlNode *)page{
    self = [super initWithNibName:@"RWTableNavigatorViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![_xml swipeViewHasPage:_page]){
		[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}

    dataSource = [_page getAllChildNodesWithName:[RWPAGE ENTRY]];
	
    [self setAppearance];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
    [helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK BACKBUTTONBACKGROUNDIMAGE] localColorName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[_lstTableView setBackgroundColor:[UIColor colorWithHexString:@"00000000"]];
	
	[helper setScrollBounces:_lstTableView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RWXmlNode *entry = [dataSource objectAtIndex:indexPath.row];
    RWXmlNode *nextPage = [_xml getPage:[entry getStringFromNode:[RWPAGE NAME]]];
    [_app.navController pushViewWithPage:nextPage];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RWTableNavigatorCell";
    RWTableNavigatorCell *cell = (RWTableNavigatorCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RWTableNavigatorCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
		[self setCellAppearance:cell];
    }

    RWXmlNode *entry = [dataSource objectAtIndex:indexPath.row];
    cell.lblTitle.text = [entry getStringFromNode:[RWPAGE NAME]];

    if([entry hasChild:[RWPAGE FRONTICON]]){
        cell.imgFrontIcon.image = [UIImage imageNamed:[entry getStringFromNode:[RWPAGE FRONTICON]]];
    }
    else{
        cell.imgFrontIcon.hidden = true;
    }

    if([entry hasChild:[RWPAGE BACKICON]]){
        cell.imgBackIcon.image = [UIImage imageNamed:[entry getStringFromNode:[RWPAGE BACKICON]]];;
    }
    else{
        cell.imgBackIcon.hidden = true;
    }

    return cell;
}

- (void)setCellAppearance:(RWTableNavigatorCell *)cell{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
    [helper setBackgroundColor:cell localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK INVISIBLE]];
	
    [helper setLabelColor:cell.lblTitle localName:[RWLOOK TEXTCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
    [helper setLabelFont:cell.lblTitle localSizeName:[RWLOOK TEXTSIZE] globalSizeName:[RWLOOK DEFAULT_ITEMTITLESIZE]
          localStyleName:[RWLOOK TEXTSTYLE] globalStyleName:[RWLOOK DEFAULT_ITEMTITLESTYLE]];
    [helper setLabelShadowColor:cell.lblTitle localName:[RWLOOK TEXTSHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
    [helper setLabelShadowOffset:cell.lblTitle localName:[RWLOOK TEXTSHADOWOFFSET] globalName:[RWLOOK DEFAULT_ITEMTITLESHADOWOFFSET]];
}

@end
