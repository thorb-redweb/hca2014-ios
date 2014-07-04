//
//  RWActivityIndicator.m
//  hca2014
//
//  Created by Thorbjørn Steen on 04/07/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RWActivityIndicator.h"
#import "RWAppDelegate.h"

@implementation RWActivityIndicator{
	RWAppDelegate *_app;
}

-(id)initWithParentViewFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message{
	return [self initWithParentViewFrame:frame title:title message:message offset:105];
}

- (id)initWithParentViewFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message offset:(int)offset
{
    self = [super initWithFrame:frame];
    if (self) {
		[self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"RWActivityIndicator" owner:self options:nil] objectAtIndex:0]];
		
		_app = [[UIApplication sharedApplication] delegate];
		
		[self setAppearance];
		
		[_boxYConstraint setConstant:offset];
		[_lblTitle setText:title];
		[_lblMessage setText:message];
		[self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.1];
    }
    return self;
}

-(void)setAppearance{
	_vwOuterBox.layer.cornerRadius = 10;
	_vwOuterBox.clipsToBounds = YES;
	_vwInnerBox.layer.cornerRadius = 10;
	_vwInnerBox.clipsToBounds = YES;
}

-(void)setTitle:(NSString *)title message:(NSString *)message{
	[_lblTitle setText:title];
	[_lblMessage setText:message];
}

-(void)startAnimation{
	_actIndicator.hidden = NO;
	[_actIndicator startAnimating];
}

-(void)hide{
	[_actIndicator stopAnimating];
	[self removeFromSuperview];
}

@end
