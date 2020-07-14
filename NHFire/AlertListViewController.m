//
//  WebViewController.m
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//

#import "AlertListViewController.h"

@interface AlertListViewController ()

@end

@implementation AlertListViewController

NSDictionary *itemDic;
NSArray *itemAllKey;
NSMutableArray *itemArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemDic count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellStyleValue1;
    
    cell.textLabel.text = [itemArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}










@end
