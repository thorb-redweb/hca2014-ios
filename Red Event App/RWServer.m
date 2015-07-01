//
//  RWServer.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWServer.h"

#import "RWAppDelegate.h"
#import "RWHandler_UploadRegistrationAttributes.h"
#import "RWHandler_GetDirections.h"

@interface RWServer ()

@property(strong, nonatomic) RWDbInterface *db;
@property(strong, nonatomic) NSURL *dataFilesFolderUrl;

@end

@implementation RWServer {
    id dumpServerDelegate;
    id updateDatabaseDelegate;
}

- (id)initWithDatabase:(RWDbInterface *)db datafilesfolderpath:(NSString *)dataFilesFolderPath {
    if (self = [super init]) {
        _db = db;
		_dataFilesFolderUrl = [NSURL URLWithString:dataFilesFolderPath];
    }
    else {NSLog(@"Server not initialized");}
    return self;
}

- (void)dumpServer:(id)delegate {
    NSLog(@"dumpServerBegin");
    dumpServerDelegate = delegate;

    RWHandler_DumpServer *handler = [[RWHandler_DumpServer alloc] init];
    handler.delegate = self;
	NSURL *dumpFileUrl = [_dataFilesFolderUrl URLByAppendingPathComponent:@"coreData.txt"];
    [handler startDownloadWithFromUrl:dumpFileUrl];

    NSLog(@"dumpServerEnd");
}

- (void)putBuildDataInDatabase:(NSMutableData *)data {
    [_db addDatabaseDump:data delegate:dumpServerDelegate];
}

- (void)noUpdateRetrieved {
    [_db clearDatabase];
    [self dumpServer:updateDatabaseDelegate];
}

- (void)getDirections:(id)delegate travelMode:(NSString *)travelMode origin:(NSString *)origin destination:(NSString *)destination {
    RWHandler_GetDirections *handler = [[RWHandler_GetDirections alloc] init];
    handler.delegate = delegate;
    NSURL *url = [[NSURL alloc] initWithString: [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?mode=%@&origin=%@&destination=%@", travelMode, origin, destination]];
    [handler startDownloadWithFromUrl:url];
}

- (void)updateDatabase:(id)delegate {
    NSLog(@"updateDatabaseBegin");
    updateDatabaseDelegate = delegate;

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *dataversion = [prefs objectForKey:@"dataversion"];

    RWHandler_UpdateFromServer *handler = [[RWHandler_UpdateFromServer alloc] init];
    handler.delegate = self;
	NSString *hcamFile = [NSString stringWithFormat:@"hcam-%@.txt", dataversion];
	NSURL *updateFileUrl = [_dataFilesFolderUrl URLByAppendingPathComponent:hcamFile];
    NSLog(@"Getting update from: %@",[updateFileUrl path]);
    [handler startDownloadWithFromUrl:updateFileUrl];

    NSLog(@"updateDatabaseEnd");
}

- (void)putUpdateDataInDatabase:(NSMutableData *)data {

    [_db updateDatabase:data delegate:updateDatabaseDelegate];
}

- (void)sendProviderDeviceToken:(NSData *)devTokenBytes {
	RWHandler_UploadRegistrationAttributes *handler = [[RWHandler_UploadRegistrationAttributes  alloc] init];
	NSURL *webserviceUrl = [_dataFilesFolderUrl URLByAppendingPathComponent:@"pushhost.php"];
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
