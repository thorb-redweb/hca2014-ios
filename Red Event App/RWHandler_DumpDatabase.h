//
//  RWDump.h
//  Red Event App
//
//  Created by redWEB Praktik on 8/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWDelegate_DumpDatabase <NSObject>
@required
- (void)continueAfterDump;
- (void)errorOccured:(NSString *)errorMessage;
@end

@interface RWHandler_DumpDatabase : NSObject {
    id <RWDelegate_DumpDatabase> _delegate;
}
@property(strong, nonatomic) id delegate;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext delegate:(id)delegate;

- (void)addDatabaseDump:(NSMutableData *)data;

@end
