//
//  RWNewsTicker.h
//  Red App
//
//  Created by Thorbjørn Steen on 2/25/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWBaseViewController.h"

@interface RWNewsticker : UIScrollView <UIGestureRecognizerDelegate>

-(void)initializeWithDatasource:(NSMutableArray *)datasource newsCells:(NSArray *)cells app:(RWAppDelegate *)app childname:(NSString *)childname;
-(void)startPaging;
-(void)stopPaging;

@end
