//
//  RWNewstickerView.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/13/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RWXmlNode.h"
#import "RWLOOK.h"
#import "RWPAGE.h"

@interface RWNewstickerView : UIScrollView <UIGestureRecognizerDelegate>

- (id)initWithFrame:(CGRect)frame subviewElement:(RWXmlNode *)page;

@end
