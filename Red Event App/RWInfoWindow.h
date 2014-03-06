//
//  RWInfoWindow.h
//  Red App
//
//  Created by Thorbjørn Steen on 11/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RWBaseMapViewController;

@interface RWInfoWindow : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBody;
@property (strong, nonatomic) NSNumber *sessionId;

@end
