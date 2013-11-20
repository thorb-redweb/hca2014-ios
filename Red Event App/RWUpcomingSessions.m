//
//  RWUpcomingSessions.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/8/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "UIView+RWViewLayout.h"

#import "RWUpcomingSessions.h"

#import "RWUpcomingSessionsTable.h"
#import "RWAppDelegate.h"
#import "RWAppearanceHelper.h"
#import "RWTextHelper.h"

#import "RWTEXT.h"
#import "RWDEFAULTTEXT.h"

@interface RWUpcomingSessions ()

@end

@implementation RWUpcomingSessions{
	RWAppDelegate *_app;
	RWXMLStore *_xml;
	
	RWUpcomingSessionsTable *_tableView;
	
	NSString *_name;
}

- (id)initWithFrame:(CGRect)frame subviewElement:(RWXmlNode *)page
{
    self = [super initWithNibName:@"RWUpcomingSessions" bundle:nil];
    if (self) {
		_app = [[UIApplication sharedApplication] delegate];
		_xml = _app.xml;
		_name = [page getStringFromNode:[RWPAGE NAME]];
		_tableView = [[RWUpcomingSessionsTable alloc] initWithFrame:frame subviewElement:page];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self.view addSubview:_tableView];
	
	[self setContraints];
	[self setAppearance];
	[self setText];
}

- (void)setContraints{
	[_lblTitle removeConstraints:_lblTitle.constraints];
	[self.view removeConstraints:self.view.constraints];
	
	[self.view RWpinChildToTop:_lblTitle];
	[self.view RWpinChildToSides:_lblTitle];
	[self.view RWpinChildrenTogetherWithTopChild:_lblTitle BottomChild:_tableView];
	[self.view RWpinChildToSides:_tableView];
	[self.view RWpinChildToBottom:_tableView];
}

-(void)setAppearance{
	RWXmlNode *localLook = [_xml getAppearanceForPage:_name];
	RWXmlNode *globalLook = [_xml getAppearanceForPage:[RWLOOK DEFAULT]];
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:localLook globalLook:globalLook];
	
	[helper setBackgroundColor:self.view localName:[RWLOOK UPCOMINGSESSIONS_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	[helper setBackgroundColor:_tableView localName:[RWLOOK UPCOMINGSESSIONS_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
	
	[helper setLabelColor:_lblTitle localName:[RWLOOK UPCOMINGSESSIONS_TITLECOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTCOLOR]];
	[helper setLabelFont:_lblTitle localSizeName:[RWLOOK UPCOMINGSESSIONS_TITLESIZE] globalSizeName:[RWLOOK DEFAULT_TITLESIZE] localStyleName:[RWLOOK UPCOMINGSESSIONS_TITLESTYLE] globalStyleName:[RWLOOK DEFAULT_TITLESTYLE]];
	[helper setLabelShadowColor:_lblTitle localName:[RWLOOK UPCOMINGSESSIONS_TITLESHADOWCOLOR] globalName:[RWLOOK DEFAULT_BACKTEXTSHADOWCOLOR]];
	[helper setLabelShadowOffset:_lblTitle localName:[RWLOOK UPCOMINGSESSIONS_TITLESHADOWOFFSET] globalName:[RWLOOK DEFAULT_TITLESHADOWOFFSET]];
}

-(void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblTitle textName:[RWTEXT UPCOMINGSESSIONS_TITLE] defaultText:[RWDEFAULTTEXT UPCOMINGSESSIONS_TITLE]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
