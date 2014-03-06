//
//  RWTypeTableController.m
//  hca2014
//
//  Created by Thorbjørn Steen on 3/4/14.
//  Copyright (c) 2014 redWEB. All rights reserved.
//

#import "UIColor+RWColor.h"
#import "RWFilterTableController.h"

@implementation RWFilterTableController{
	NSArray *_datasource;
	NSString *_selectedName;
}

-(id)initWithDatasource:(NSArray *)datasource defaultName:(NSString *)defaultName{
	if(self = [super init]){
		_datasource = datasource;
		_selectedName = defaultName;
	}
	return self;
}

- (NSString *)getSelectedName{
	return _selectedName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _datasource.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	// my code
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//	// my code
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"RWTypeTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _datasource[indexPath.row];
	
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//	// my code
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	_selectedName = _datasource[indexPath.row];
}
@end
