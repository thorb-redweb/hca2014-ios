//
//  RWHandler_DumpServer.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/15/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWHandler_DumpServer.h"

@interface RWHandler_DumpServer ()

@property(strong, nonatomic) NSMutableData *data;
@property(strong, nonatomic) NSURLConnection *openConnection;
@end

@implementation RWHandler_DumpServer

- (void)startDownloadWithFromUrl:(NSURL *)dumpFileUrl {
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:dumpFileUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    _data = [[NSMutableData alloc] initWithLength:0];
    _openConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    NSLog(@"Start Dump Download in RWHandler_DumpServer.m");

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_data setLength:0];
    NSLog(@"did receive response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
    NSLog(@"did receive data");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"did fail with error");
    NSLog(@"Connection failed: %@", error.description);
	[_delegate errorOccured:[NSString stringWithFormat: @"Connection failed: %@", error.description]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    NSLog(@"connection did finish loading");
//    int i = 0;
//    while (i < 2000000000) {
//        i++;
//    }

    [_delegate putBuildDataInDatabase:_data];

}

@end
