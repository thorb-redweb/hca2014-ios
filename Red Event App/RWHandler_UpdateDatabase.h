//
//  RWHandler_UpdateDatabase.h
//  Red Event App
//
//  Created by redWEB Praktik on 9/2/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWDbInterface.h"

@protocol RWDelegate_UpdateDatabase <NSObject>
@required
- (void)continueAfterUpdate;
- (void)errorOccured:(NSString *)errorMessage;
@end

@interface RWHandler_UpdateDatabase : NSObject {
    id <RWDelegate_UpdateDatabase> _delegate;
}
@property(strong, nonatomic) id delegate;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext parent:(RWDbInterface *)db delegate:(id)delegate;

- (void)updateDatabase:(NSMutableData *)data;

@end
