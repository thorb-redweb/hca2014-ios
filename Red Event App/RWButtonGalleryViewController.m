//
//  RWButtonGalleryViewController.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/14/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWButtonGalleryViewController.h"
#import "RWNode.h"

#import "RWPAGE.h"

@interface RWButtonGalleryViewController ()

@end

@implementation RWButtonGalleryViewController

- (id)initWithName:(NSString *)name
{
    self = [super initWithNibName:@"RWButtonGalleryViewController" bundle:nil name:name];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	if ([_page hasChild:[RWPAGE BUTTON1CHILD]]) {[_btn1 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON2CHILD]]) {[_btn2 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON3CHILD]]) {[_btn3 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON4CHILD]]) {[_btn4 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON5CHILD]]) {[_btn5 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON6CHILD]]) {[_btn6 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON7CHILD]]) {[_btn7 setHidden:false];}
	if ([_page hasChild:[RWPAGE BUTTON8CHILD]]) {[_btn8 setHidden:false];}

	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"julebaggrund.jpg"]]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn1Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON1CHILD]];
}

-(void)btn2Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON2CHILD]];
}

-(void)btn3Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON3CHILD]];
}

-(void)btn4Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON4CHILD]];
}

-(void)btn5Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON5CHILD]];
}

-(void)btn6Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON6CHILD]];
}

-(void)btn7Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON7CHILD]];
}

-(void)btn8Pressed:(id)sender{
	[self goToNextPage:[RWPAGE BUTTON8CHILD]];
}

-(void)goToNextPage:(NSString *)button{
	if ([_page hasChild:button]) {
		RWNode *nextPage = [_xml getPage:[_page getStringFromNode:button]];
		[_app.navController pushViewWithParameters:[nextPage getDictionaryFromNode]];
	}
}

@end
