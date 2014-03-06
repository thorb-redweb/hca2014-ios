//
//  RWTypeTableController.h
//  hca2014
//
//  Created by Thorbjørn Steen on 3/4/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWFilterTableController : NSObject <UITableViewDataSource, UITableViewDelegate>

-(id)initWithDatasource:(NSArray *)datasource defaultName:(NSString *)defaultName;

- (NSString *)getSelectedName;

@end
