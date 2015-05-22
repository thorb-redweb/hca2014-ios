//
// Created by Thorbjørn Steen on 21/05/15.
// Copyright (c) 2015 redWEB. All rights reserved.
//

#import "RWHandler_GetDirections.h"


@interface RWHandler_GetDirections ()

@property(strong, nonatomic) NSMutableData *data;
@property(strong, nonatomic) NSURLConnection *openConnection;
@end

@implementation RWHandler_GetDirections

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

    NSError *dictError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableLeaves error:&dictError];
    if (dictError != nil) {
        NSLog(@"did fail with error");
        NSLog(@"Dictionary setup failed in RWHandler_GetDirections:connectionDidFinishLoading: %@", dictError.description);
        [_delegate errorOccured:[NSString stringWithFormat: @"Dictionary setup failed in RWHandler_GetDirections:connectionDidFinishLoading: %@", dictError.description]];
        return;
    }

    [_delegate retrieveDirections:dict];
}

@end