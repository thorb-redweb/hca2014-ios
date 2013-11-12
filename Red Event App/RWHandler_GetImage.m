//
//  RWHandler_GetImage.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWHandler_GetImage.h"

#import "RWAppDelegate.h"
#import "RWXMLStore.h"

@interface RWHandler_GetImage ()

@property(strong, nonatomic) NSMutableData *data;
@property(strong, nonatomic) NSURLConnection *openConnection;

@end

@implementation RWHandler_GetImage {
    CGSize _wantedSize;
	NSURL *_url;
}

- (void)startDownload:(NSURL *)url {
    [self startDownload:url wantedSize:CGSizeMake(0, 0)];
}

- (void)startDownload:(NSURL *)url wantedSize:(CGSize)wantedSize {

	_url = url;
    _wantedSize = wantedSize;
	
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:url];
    _data = [[NSMutableData alloc] initWithLength:0];
    _openConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    NSLog(@"Start Image Download in RWHandler_GetImage.m");

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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    UIImage *image = [[UIImage alloc] initWithData:_data];

    if (_wantedSize.height != 0 && _wantedSize.width != 0 && (image.size.width != _wantedSize.width || image.size.height != _wantedSize.height)) {
        UIGraphicsBeginImageContextWithOptions(_wantedSize, NO, 0.0f);
        [image drawInRect:CGRectMake(0.0, 0.0, _wantedSize.width, _wantedSize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else if (_wantedSize.height == 0 && _wantedSize.width > 0 && image.size.width != _wantedSize.width) {
        float oldWidth = image.size.width;
        float scaleFactor = _wantedSize.width / oldWidth;
        float newHeight = image.size.height * scaleFactor;
        float newWidth = oldWidth * scaleFactor;

        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
        [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    [_delegate getReturnImage:image url:_url];
}


@end
