//
//  RWBaseViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/30/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RWAppDelegate.h"
#import "RWDbInterface.h"
#import "RWServer.h"

#import "RWDbArticles.h"
#import "RWDbCommon.h"
#import "RWDbEvents.h"
#import "RWDbSessions.h"
#import "RWDbVenues.h"

#import "RWAppearanceHelper.h"
#import "RWTextHelper.h"

#import "RWDEFAULTTEXT.h"
#import "RWLOOK.h"
#import "RWPAGE.h"
#import "RWTEXT.h"
#import "RWTYPE.h"

@interface RWBaseViewController : UIViewController {
@protected
    RWAppDelegate *_app;
@protected
    RWDbInterface *_db;
@protected
    RWServer *_sv;
@protected
    RWXMLStore *_xml;

@protected
    RWXmlNode *_page;
@protected
    NSString *_name;
@protected
    NSString *_childname;

@protected
    RWXmlNode *_localLook;
@protected
    RWXmlNode *_globalLook;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name;

- (NSString *)description;

- (NSString *)getName;

@end
