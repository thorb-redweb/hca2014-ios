//
//  RWHandler_UpdateDatabase.m
//  Red Event App
//
//  Created by redWEB Praktik on 9/2/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "MyLog.h"

#import "RWHandler_UploadRegistrationAttributes.h"

@interface RWHandler_UploadRegistrationAttributes ()

@property(strong, nonatomic) NSMutableData *data;
@property(strong, nonatomic) NSURLConnection *openConnection;
@end

@implementation RWHandler_UploadRegistrationAttributes

- (void)startUploadWithFromUrl:(NSURL *)serviceUrl deviceToken:(NSData *)deviceToken{
    [self startUploadWithFromUrl:serviceUrl deviceToken:deviceToken name:@""];
}

- (void)startUploadWithFromUrl:(NSURL *)serviceUrl deviceToken:(NSData *)deviceToken name:(NSString *)name{
    NSString *strippedDeviceToken = [deviceToken description];
    strippedDeviceToken = [strippedDeviceToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    strippedDeviceToken = [strippedDeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *bodyData = [NSString stringWithFormat:@"action=uploadUserData&platformid=2&regid=%@&name=%@",strippedDeviceToken,name];

    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:serviceUrl];

    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];

    _data = [[NSMutableData alloc] initWithLength:0];
    _openConnection = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    DDLogVerbose(@"Start registration attributes upload in RWHandler_UploadRegistrationAttributes.m");
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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}


@end
