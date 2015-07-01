//
//  RWHandler_UpdateDatabase.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/2/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWHandler_UpdateFromServer.h"
#import "RWAppDelegate.h"

@interface RWHandler_UpdateFromServer ()

@property(strong, nonatomic) NSMutableData *data;
@property(strong, nonatomic) NSURLConnection *openConnection;
@end

@implementation RWHandler_UpdateFromServer

- (void)startDownloadWithFromUrl:(NSURL *)updateFileUrl {
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:updateFileUrl];
    _data = [[NSMutableData alloc] initWithLength:0];
    _openConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    NSLog(@"Start Update Download in RWHandler_UpdateDatabase.m");

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
    NSLog(@"did fail with error");
    NSLog(@"Connection failed: %@", error.description);
	[_delegate errorOccured:[NSString stringWithFormat: @"Connection failed: %@", error.description]];	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *result = [[NSString alloc] initWithData:_data encoding:NSASCIIStringEncoding];

    //If update file does not exist on server
    if(result && [result isKindOfClass:[NSString class]] && [result rangeOfString:@"404 Not Found"].location != NSNotFound){ //
        [_delegate noUpdateRetrieved];
        return;
    }

    [_delegate putUpdateDataInDatabase:_data];
}


@end
