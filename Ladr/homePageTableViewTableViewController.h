//
//  homePageTableViewTableViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/5/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "GroupTableViewController.h"

@interface homePageTableViewTableViewController : UITableViewController


@property (nonatomic, strong) NSArray* userGroups;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end
