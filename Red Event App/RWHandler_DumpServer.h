//
//  RWHandler_DumpServer.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWDelegate_DumpServer <NSObject>
@required
- (void)errorOccured:(NSString *)errorMessage;
- (void)putBuildDataInDatabase:(NSMutableData *)data;
@end

@interface RWHandler_DumpServer : NSObject {
    id <RWDelegate_DumpServer> _delegate;
}

@property(strong, nonatomic) id delegate;

- (void)startDownloadWithFromUrl:(NSURL *)dumpFileUrl;

@end
