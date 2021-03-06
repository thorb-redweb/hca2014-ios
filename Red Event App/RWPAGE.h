//
//  RWPAGE.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWPAGE : NSObject
+ (NSString *)PAGESFILENAME;

+ (NSString *)FRONTPAGETYPE;

+ (NSString *)GLOBAL;

//Activate Subcomponents
+ (NSString *)USEREDUPLOAD;

//Page Globals
+ (NSString *)ARTICLEID;
+ (NSString *)CATID;
+ (NSString *)CATIDS;
+ (NSString *)CHILD;
+ (NSString *)CHILD2;
+ (NSString *)FRONTPAGE;
+ (NSString *)NAME;
+ (NSString *)NAVNAME;
+ (NSString *)PAGE;
+ (NSString *)PARENT;

+ (NSString *)PARENTPAGE;
+ (NSString *)POPTWICE;
+ (NSString *)PUSHMESSAGEID;
+ (NSString *)PUSHGROUPID;
+ (NSString *)PUSHGROUPIDS;
+ (NSString *)RETURNBUTTON;
+ (NSString *)RETURNONTAP;
+ (NSString *)SECTION;
+ (NSString *)SESSIONID;
+ (NSString *)TABIMAGE;
+ (NSString *)TABNAME;
+ (NSString *)TYPE;

+ (NSString *)URL;

+ (NSString *)VENUEID;

//SplitView Component Specific
+ (NSString *)BOTTOM;
+ (NSString *)COMPONENTTYPE;
+ (NSString *)TOP;

//ButtonGallery Specific
+ (NSString *)BUTTON1CHILD;
+ (NSString *)BUTTON2CHILD;
+ (NSString *)BUTTON3CHILD;
+ (NSString *)BUTTON4CHILD;
+ (NSString *)BUTTON5CHILD;
+ (NSString *)BUTTON6CHILD;
+ (NSString *)BUTTON7CHILD;
+ (NSString *)BUTTON8CHILD;

//PushMessageList Specific
+ (NSString *)SUBSCRIPTIONS;

//RedUpload Specific
+ (NSString *)REDUPLOADFOLDERTYPE;
+ (NSString *)REDUPLOADFOLDERTYPESESSION;
+ (NSString *)REDUPLOADFOLDERTYPEOTHER;
+ (NSString *)REDUPLOADFOLDERID;

//TableNavigator Specific
+ (NSString *)ENTRY;
+ (NSString *)BACKICON;
+ (NSString *)FRONTICON;

//Map Activity Specific
+ (NSString *)LATITUDE;
+ (NSString *)LONGITUDE;
+ (NSString *)ZOOM;

//Detail View Specific
+ (NSString *)BODYUSESHTML;

//Tags
+ (NSString *)TAG_SESSIONTITLE;

+ (NSString *)FOLDER;

+ (NSString *)FILEPATH;
@end
