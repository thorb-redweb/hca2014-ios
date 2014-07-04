//
//  RWActivityIndicator.h
//  hca2014
//
//  Created by Thorbjørn Steen on 04/07/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWActivityIndicator : UIControl
@property (weak, nonatomic) IBOutlet UIView *vwOuterBox;
@property (weak, nonatomic) IBOutlet UIView *vwInnerBox;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boxYConstraint;

- (id)initWithParentViewFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message;
- (id)initWithParentViewFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message offset:(int)offset;
-(void)setTitle:(NSString *)title message:(NSString *)message;
- (void)hide;

@end
