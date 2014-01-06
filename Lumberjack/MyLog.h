//
//  MyLog.h
//  Red App
//
//  Created by Thorbjørn Steen on 1/3/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

#define LOG_LEVEL_GLOBAL (-1)

@interface MyLog : NSObject
	extern int ddLogLevel;
@end
