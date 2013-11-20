//
//  RWUpcomingSessions.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/8/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWXmlNode;

@interface RWUpcomingSessions : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

- (id)initWithFrame:(CGRect)frame subviewElement:(RWXmlNode *)page;

@end
