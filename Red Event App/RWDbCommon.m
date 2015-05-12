//
//  RWDbCommon.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWDbCommon.h"
#import "RWDbHelper.h"

@implementation RWDbCommon {
    RWDbHelper *_dbHelper;
}
- (id)initWithHelper:(RWDbHelper *)helper {
    if (self = [super init]) {
        _dbHelper = helper;
    }
    else {NSLog(@"RWDbCommon not initialized");}
    return self;
}
@end
