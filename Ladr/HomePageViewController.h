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
#import "SWRevealViewController.h"

@interface HomePageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>


@property (nonatomic, strong) NSArray* userGroups;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end
