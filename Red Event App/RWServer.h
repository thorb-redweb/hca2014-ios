//
//  RWServer.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWDbInterface.h"
#import "RWHandler_DumpServer.h"
#import "RWHandler_GetImage.h"
#import "RWHandler_UpdateFromServer.h"


@interface RWServer : NSObject <RWDelegate_DumpServer, RWDelegate_UpdateFromServer>

- (id)initWithDatabase:(RWDbInterface *)db datafilesfolderpath:(NSString *)dataFilesFolderPath;

- (void)dumpServer:(NSObject *)delegate;

- (void)updateDatabase:(NSObject *)delegate;

//- (void)getImage:(NSObject *)delegate imageLink:(NSString *)imagePath;

//- (void)getImage:(NSObject *)delegate imageLink:(NSString *)imagePath wantedSize:(CGSize)wantedSize;

- (void)sendProviderDeviceToken:(void const *)devTokenBytes;
@end
