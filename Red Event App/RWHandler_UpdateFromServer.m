//
//  RWHandler_UpdateDatabase.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/2/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWHandler_UpdateFromServer.h"

@interface RWHandler_UpdateFromServer ()

@property(strong, nonatomic) NSMutableData *data;
@property(strong, nonatomic) NSURLConnection *openConnection;
@end

@implementation RWHandler_UpdateFromServer

- (void)startDownloadWithFromUrl:(NSURL *)updateFileUrl {
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:updateFileUrl];
    _data = [[NSMutableData alloc] initWithLength:0];
    _openConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    DDLogVerbose(@"Start Update Download in RWHandler_UpdateDatabase.m");

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    DDLogError(@"did fail with error");
    DDLogError(@"Connection failed: %@", error.description);
	[_delegate errorOccured:[NSString stringWithFormat: @"Connection failed: %@", error.description]];	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_delegate putUpdateDataInDatabase:_data];
}


@end
