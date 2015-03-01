//
//  RecentGamesTableViewObject.m
//  Ladr
//
//  Created by Markus Notti on 2/28/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "RecentGamesTableViewObject.h"


@implementation RecentGamesTableViewObject


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSLog(@"returning sections");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"I'M IN A CELL BITCH";
    NSLog(@"cell assigned value");
    
    return cell;
}


@end
