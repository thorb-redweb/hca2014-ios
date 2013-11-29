//
//  RWBaseViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/30/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWBaseViewController.h"

#import "RWAppDelegate.h"
#import "RWDbInterface.h"

@interface RWBaseViewController ()

@end

@implementation RWBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil page:(RWXmlNode *)page {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _app = [[UIApplication sharedApplication] delegate];
        _db = _app.db;
        _sv = _app.sv;
        _xml = _app.xml;
        _page = page;
        _name = [_page getStringFromNode:[RWPAGE NAME]];
        if ([_page hasChild:[RWPAGE CHILD]])
            _childname = [_page getStringFromNode:[RWPAGE CHILD]];
        else
            _childname = @"No Child";

        if([_xml.appearance hasChild:_name])  {
            _localLook = [_xml.appearance getChildFromNode:_name];
        }
        _globalLook = [_xml.appearance getChildFromNode:[RWLOOK DEFAULT]];
		
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	self.navigationController.navigationBar.hidden = YES;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"%@: \nname: %@\nchildname: %@", [self class], _name, _childname];
    return description;
}


//- (NSString *)description {
//    NSString *description = [NSString stringWithFormat:@"%@: \nname: %@\nchildname: %@\nframe: [%f,%f,%f,%f]", [self class], _name, _childname, self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height];
//    return description;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)getName{
	return _name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
