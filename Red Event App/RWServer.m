//
//  RWServer.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWServer.h"

#import "RWAppDelegate.h"

@interface RWServer ()

@property(strong, nonatomic) RWDbInterface *db;
@property(strong, nonatomic) NSString *dataFilesFolderPath;

@end

@implementation RWServer {
    id dumpServerDelegate;
    id updateDatabaseDelegate;
}

- (id)initWithDatabase:(RWDbInterface *)db datafilesfolderpath:(NSString *)dataFilesFolderPath {
    if (self = [super init]) {
        _db = db;
        _dataFilesFolderPath = dataFilesFolderPath;
    }
    else {NSLog(@"Server not initialized");}
    return self;
}

- (void)dumpServer:(id)delegate {
    NSLog(@"dumpServerBegin");
    dumpServerDelegate = delegate;

    RWHandler_DumpServer *handler = [[RWHandler_DumpServer alloc] init];
    handler.delegate = self;
    NSString *dumpFileString = [NSString stringWithFormat:@"%@%@", _dataFilesFolderPath, @"coreData.txt"];
    NSURL *dumpFileUrl = [NSURL URLWithString:dumpFileString];
    [handler startDownloadWithFromUrl:dumpFileUrl];

    NSLog(@"dumpServerEnd");
}

- (void)putBuildDataInDatabase:(NSMutableData *)data {

    [_db addDatabaseDump:data delegate:dumpServerDelegate];
}

- (void)updateDatabase:(id)delegate {
    NSLog(@"updateDatabaseBegin");
    updateDatabaseDelegate = delegate;

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *dataversion = [prefs objectForKey:@"dataversion"];

    RWHandler_UpdateFromServer *handler = [[RWHandler_UpdateFromServer alloc] init];
    handler.delegate = self;
    NSString *updateFileString = [NSString stringWithFormat:@"%@hcam-%@.txt", _dataFilesFolderPath, dataversion];
	NSLog(@"Getting update from: %@",updateFileString);
    NSURL *updateFileUrl = [NSURL URLWithString:updateFileString];
    [handler startDownloadWithFromUrl:updateFileUrl];

    NSLog(@"updateDatabaseEnd");
}

- (void)putUpdateDataInDatabase:(NSMutableData *)data {

    [_db updateDatabase:data delegate:updateDatabaseDelegate];
}

- (void)getImage:(NSObject *)delegate imageLink:(NSURL *)url {
    RWHandler_GetImage *handler = [[RWHandler_GetImage alloc] init];
    handler.delegate = delegate;
    [handler startDownload:url];
}

- (void)getImage:(NSObject *)delegate imageLink:(NSURL *)url wantedSize:(CGSize)wantedSize {
    RWHandler_GetImage *handler = [[RWHandler_GetImage alloc] init];
    handler.delegate = delegate;
    [handler startDownload:url wantedSize:wantedSize];
}

- (void)errorOccured:(NSString *)errorMessage{
	if (dumpServerDelegate != nil) {
		[dumpServerDelegate errorOccured:errorMessage];
	}
	else if(updateDatabaseDelegate != nil){
		[updateDatabaseDelegate errorOccured:errorMessage];
	}	
}

@end
