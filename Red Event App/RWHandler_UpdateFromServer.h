//
//  RWHandler_UpdateDatabase.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/2/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWDelegate_UpdateFromServer <NSObject>
@required
- (void)errorOccured:(NSString *)errorMessage;
- (void)putUpdateDataInDatabase:(NSMutableData *)data;
- (void)updateFromServerWithCoreData;
@end

@interface RWHandler_UpdateFromServer : NSObject {
    id <RWDelegate_UpdateFromServer> _delegate;
}

@property(strong, nonatomic) id delegate;

- (void)startDownloadWithFromUrl:(NSURL *)dumpFileUrl;

@end
