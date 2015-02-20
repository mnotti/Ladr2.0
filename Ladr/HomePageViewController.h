//
//  homePageTableViewTableViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/5/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "HomePageCell.h"

#import "GroupTableViewController.h"
#import "SWRevealViewController.h"

//#import <FacebookSDK/FacebookSDK.h>

@interface HomePageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;


@property (nonatomic, strong) NSArray* userGroups;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) NSMutableArray* visibleCells;
@property (nonatomic) NSMutableArray* groupImages;
@property (nonatomic) NSMutableArray* actuallyGroups;

@end
