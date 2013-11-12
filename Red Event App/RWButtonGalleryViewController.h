//
//  RWButtonGalleryViewController.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBaseViewController.h"

@interface RWButtonGalleryViewController : RWBaseViewController

@property(weak, nonatomic) IBOutlet UIButton *btn1;
@property(weak, nonatomic) IBOutlet UIButton *btn2;
@property(weak, nonatomic) IBOutlet UIButton *btn3;
@property(weak, nonatomic) IBOutlet UIButton *btn4;
@property(weak, nonatomic) IBOutlet UIButton *btn5;
@property(weak, nonatomic) IBOutlet UIButton *btn6;
@property(weak, nonatomic) IBOutlet UIButton *btn7;
@property(weak, nonatomic) IBOutlet UIButton *btn8;

- (id)initWithName:(NSString *)name;

- (IBAction)btn1Pressed:(id)sender;
- (IBAction)btn2Pressed:(id)sender;
- (IBAction)btn3Pressed:(id)sender;
- (IBAction)btn4Pressed:(id)sender;
- (IBAction)btn5Pressed:(id)sender;
- (IBAction)btn6Pressed:(id)sender;
- (IBAction)btn7Pressed:(id)sender;
- (IBAction)btn8Pressed:(id)sender;

@end
