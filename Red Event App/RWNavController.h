//
//  RWNavController.h
//  hca2014
//
//  Created by Thorbjørn Steen on 3/3/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RWXmlNode;

@interface RWNavController : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

-(void)handleNewPage:(RWXmlNode *)page;

-(IBAction)btnHomePushed;
-(IBAction)btnBackPushed;

@end
