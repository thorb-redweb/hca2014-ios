//
//  RWHandler_UpdateDatabase.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/2/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWHandler_UploadRegistrationAttributes : NSObject

@property(strong, nonatomic) id delegate;

- (void)startUploadWithFromUrl:(NSURL *)serviceUrl deviceToken:(NSData *)deviceToken;
- (void)startUploadWithFromUrl:(NSURL *)serviceUrl deviceToken:(NSData *)deviceToken name:(NSString *)name;

@end
