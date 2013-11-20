//
//  RWSessionMapViewController.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/26/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "RWBaseMapViewController.h"

@interface RWSessionMapViewController : RWBaseMapViewController

- (id)initWithName:(NSString *)name sessionid:(int)sessionid;

@end
