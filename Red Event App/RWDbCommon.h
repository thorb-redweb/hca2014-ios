//
//  RWDbCommon.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWDbHelper;

@interface RWDbCommon : NSObject

- (id)initWithHelper:(RWDbHelper *)context;
@end
