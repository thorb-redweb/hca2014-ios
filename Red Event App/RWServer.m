//
//  RWServer.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWServer.h"

#import "RWAppDelegate.h"
#import "RWHandler_UploadRegistrationAttributes.h"

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
    else {DDLogWarn(@"Server not initialized");}
    return self;
}

- (void)dumpServer:(id)delegate {
    DDLogVerbose(@"dumpServerBegin");
    dumpServerDelegate = delegate;

    RWHandler_DumpServer *handler = [[RWHandler_DumpServer alloc] init];
    handler.delegate = self;
    NSString *dumpFileString = [NSString stringWithFormat:@"%@%@", _dataFilesFolderPath, @"getDump.php"];
    NSURL *dumpFileUrl = [NSURL URLWithString:dumpFileString];
    [handler startDownloadWithFromUrl:dumpFileUrl];

    DDLogVerbose(@"dumpServerEnd");
}

- (void)putBuildDataInDatabase:(NSMutableData *)data {

    [_db addDatabaseDump:data delegate:dumpServerDelegate];
}

- (void)updateDatabase:(id)delegate {
    DDLogVerbose(@"updateDatabaseBegin");
    updateDatabaseDelegate = delegate;

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *dataversion = [prefs objectForKey:@"dataversion"];

    RWHandler_UpdateFromServer *handler = [[RWHandler_UpdateFromServer alloc] init];
    handler.delegate = self;
    NSString *updateFileString = [NSString stringWithFormat:@"%@hcam-%@.txt", _dataFilesFolderPath, dataversion];
	DDLogDebug(@"Getting update from: %@",updateFileString);
    NSURL *updateFileUrl = [NSURL URLWithString:updateFileString];
    [handler startDownloadWithFromUrl:updateFileUrl];

    DDLogVerbose(@"updateDatabaseEnd");
}

- (void)putUpdateDataInDatabase:(NSMutableData *)data {

    [_db updateDatabase:data delegate:updateDatabaseDelegate];
}

- (void)sendProviderDeviceToken:(NSData *)devTokenBytes {
	RWHandler_UploadRegistrationAttributes *handler = [[RWHandler_UploadRegistrationAttributes  alloc] init];
    NSString *webserviceString = [NSString stringWithFormat:@"%@pushhost.php", _dataFilesFolderPath];
    NSURL *webserviceUrl = [NSURL URLWithString:webserviceString];
    [handler startUploadWithFromUrl:webserviceUrl deviceToken:devTokenBytes];
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
