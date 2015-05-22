//
// Created by Thorbjørn Steen on 21/05/15.
// Copyright (c) 2015 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RWDelegate_GetDirections <NSObject>
@required
- (void)errorOccured:(NSString *)errorMessage;
- (void)retrieveDirections:(NSDictionary *)data;
@end

@interface RWHandler_GetDirections : NSObject {
    id <RWDelegate_GetDirections> _delegate;
}

@property(strong, nonatomic) id delegate;

- (void)startDownloadWithFromUrl:(NSURL *)updateFileUrl;

@end