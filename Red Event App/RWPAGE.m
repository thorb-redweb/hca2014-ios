//
//  RWPAGE.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWPAGE.h"

@implementation RWPAGE

+ (NSString *)PAGESFILENAME {return @"pages.xml";}

+ (NSString *)FRONTPAGETYPE {return @"FrontPage";}

//Page Globals
+ (NSString *)ARTICLEID {return @"articleid";}
+ (NSString *)CATID {return @"catid";}
+ (NSString *)CHILD {return @"child";}
+ (NSString *)FRONTPAGE {return @"frontpage";}
+ (NSString *)NAME {return @"name";}
+ (NSString *)NAVNAME {return @"navname";}
+ (NSString *)PAGE {return @"page";}
+ (NSString *)PARENT {return @"parent";}
+ (NSString *)RETURNBUTTON {return @"returnbutton";}
+ (NSString *)RETURNONTAP {return @"returnontap";}
+ (NSString *)SESSIONID {return @"sessionid";}
+ (NSString *)SECTION {return @"section";}
+ (NSString *)TABIMAGE {return @"tabimage";}
+ (NSString *)TABNAME {return @"tabname";}
+ (NSString *)TYPE {return @"type";}
+ (NSString *)VENUEID {return @"venueid";}

//SplitView Component Specific
+ (NSString *)BOTTOM {return @"bottom";}
+ (NSString *)COMPONENTTYPE {return @"componenttype";}
+ (NSString *)TOP {return @"top";}

//ButtonGallery Specific
+ (NSString *)BUTTON1CHILD {return @"button1child";}
+ (NSString *)BUTTON2CHILD {return @"button2child";}
+ (NSString *)BUTTON3CHILD {return @"button3child";}
+ (NSString *)BUTTON4CHILD {return @"button4child";}
+ (NSString *)BUTTON5CHILD {return @"button5child";}
+ (NSString *)BUTTON6CHILD {return @"button6child";}
+ (NSString *)BUTTON7CHILD {return @"button7child";}
+ (NSString *)BUTTON8CHILD {return @"button8child";}

//TableNavigator Specific
+ (NSString *)ENTRY {return @"entry";}
+ (NSString *)FRONTICON {return @"fronticon";}
+ (NSString *)BACKICON {return @"backicon";}

//Map Activity Specific
+ (NSString *)LATITUDE {return @"latitude";}
+ (NSString *)LONGITUDE {return @"longitude";}
+ (NSString *)ZOOM {return @"zoom";}

//Detail View Specific
+ (NSString *)BODYUSESHTML {return @"bodyuseshtml";}

//Tags
+ (NSString *)TAG_SESSIONTITLE {return @"@SessionTitle";}

@end
