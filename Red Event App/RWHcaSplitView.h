//
//  RWHcaSplitView.h
//  Red App
//
//  Created by Thorbjørn Steen on 2/25/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWBaseViewController.h"
#import "RWNewsticker.h"
#import "RWNewstickerCell.h"

@interface RWHcaSplitView : RWBaseViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *vwTop;
@property (weak, nonatomic) IBOutlet UIView *vwBottom;

@property (weak, nonatomic) IBOutlet UITableView *lstSessions;

@property (weak, nonatomic) IBOutlet RWNewsticker *nwsTicker;
@property (weak, nonatomic) IBOutlet UIView *vwNewstickerContentView;
@property (weak, nonatomic) IBOutlet RWNewstickerCell *nwsCell1;
@property (weak, nonatomic) IBOutlet RWNewstickerCell *nwsCell2;
@property (weak, nonatomic) IBOutlet RWNewstickerCell *nwsCell3;

- (id)initWithPage:(RWXmlNode *)page;

@end
