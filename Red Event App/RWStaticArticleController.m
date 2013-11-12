//
//  RWStaticArticleController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWStaticArticleController.h"
#import "RWArticleVM.h"
#import "RWAppearanceHelper.h"

@interface RWStaticArticleController ()

@end

@implementation RWStaticArticleController {
    int _contid;

    RWArticleVM *_model;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name articleid:(int)contid {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil name:name];
    if (self) {
        _contid = contid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _model = [_db.Articles getVMFromId:_contid];

    [_webBody loadHTMLString:_model.introtext baseURL:nil];
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK STATICARTICLE_BACKGROUNDCOLOR] globalName:[RWLOOK GLOBAL_BACKCOLOR]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
