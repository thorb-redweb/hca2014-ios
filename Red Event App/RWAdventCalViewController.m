//
//  RWAdventCalViewController.m
//  Jule App
//
//  Created by Thorbjørn Steen on 10/29/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWAdventCalViewController.h"
#import "RWAdventWindowViewController.h"
#import "RWArticleVM.h"

@interface RWAdventCalViewController ()

@end

@implementation RWAdventCalViewController{
	NSArray *_articleVMs;
}

-(id)initWithName:(NSString *)name{
	self = [super initWithNibName:@"RWAdventCalViewController" bundle:nil name:name];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	int catid = [_page getIntegerFromNode:[RWPAGE CATID]];
	
	_articleVMs = [_db.Articles getVMListFromCatId:catid];
	
	_articleVMs = [_articleVMs sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd"];
		NSDate *first = [dateFormat dateFromString:[(RWArticleVM *)a title]];
		NSDate *second = [dateFormat dateFromString:[(RWArticleVM *)b title]];
		return [first compare:second];
	}];
	
	NSArray *buttonArray = [[NSArray alloc] initWithObjects:_btn1,_btn2,_btn3,_btn4,_btn5,_btn6,_btn7,_btn8,_btn9,_btn10,_btn11,_btn12,_btn13,_btn14,_btn15,_btn16,_btn17,_btn18,_btn19,_btn20,_btn21,_btn22,_btn23,_btn24, nil];
	for(int i = 0; i < buttonArray.count; i++){
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd"];
		NSDate *openDate = [dateFormat dateFromString:[_articleVMs[i] title]];
		NSDate *today = [[NSDate alloc] init];
		
		UIButton *button = buttonArray[i];
		if ([openDate compare: today] == NSOrderedAscending) {
			[button setAlpha:1];
			[button setBackgroundColor:[UIColor clearColor]];
		} else {
			[button setAlpha:0.6];
			[button setBackgroundColor:[UIColor blackColor]];
		}		
	}
	
    [self setAppearance];
}

- (void)setAppearance{
	RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];
	
	[helper setBackgroundTileImageOrColor:self.view localImageName:[RWLOOK ADVENTCAL_BACKGROUNDIMAGE] localColorName:[RWLOOK ADVENTCAL_BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];
}

- (IBAction)openWindow:(id)sender{
	UIView *imgWindow = (UIView *)sender;
	int tag = imgWindow.tag;
	RWArticleVM *chosenArticle = _articleVMs[tag];
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
	NSDate *openDate = [dateFormat dateFromString:[chosenArticle title]];
	NSDate *today = [[NSDate alloc] init];
	
	if ([openDate compare: today] == NSOrderedAscending) {
		RWXmlNode *childPage = [_xml getPage:_childname];
        NSMutableDictionary *childDictionary = [[NSMutableDictionary alloc] initWithDictionary:[childPage getDictionaryFromNode]];
		[childDictionary setObject:chosenArticle.articleid forKey:[RWPAGE ARTICLEID]];
		[_app.navController pushViewWithParameters:childDictionary];
	}
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
