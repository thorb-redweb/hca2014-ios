//
//  RWTabBar.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/19/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWTabBar.h"
#import "TouchXML.h"
#import "RWAppDelegate.h"
#import "RWPAGE.h"

@implementation RWTabBar {
    RWXMLStore *_xml;
}
- (void)baseInit {
    RWAppDelegate *app = [[UIApplication sharedApplication] delegate];

    _xml = app.xml;
    RWXmlNode *pages = _xml.pages;

    _tabpages = [[NSMutableArray alloc] init];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    int i = 0;
    for (RWXmlNode *page in pages.children) {
		NSString *tabname = @"";
		if([page hasChild:[RWPAGE TABNAME]]){
			tabname = [page getStringFromNode:[RWPAGE TABNAME]];
		}
		UIImage *tabimage = nil;
		if ([page hasChild:[RWPAGE TABIMAGE]]) {
			tabimage = [UIImage imageNamed:[page getStringFromNode:[RWPAGE TABIMAGE]]];
		}
		
		
        if (!([tabname isEqual:@""]) || tabimage != nil) {
            UITabBarItem *btnPage = [[UITabBarItem alloc] initWithTitle:tabname image:tabimage tag:i];
            [_tabpages addObject:page];
            [items addObject:btnPage];
            i++;
        }

    }

    [self setItems:items animated:NO];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)setAppearance {

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
