//
//  RWHandler_GetImage.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/16/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWDelegate_GetImage <NSObject>
@required
- (void)getReturnImage:(UIImage *)image url:(NSURL *)url;
@end

@interface RWHandler_GetImage : NSObject {
    id <RWDelegate_GetImage> _delegate;
}

@property(strong, nonatomic) id delegate;

- (void)startDownload:(NSURL *)url wantedSize:(CGSize)wantedSize;

- (void)startDownload:(NSURL *)url;

@end
