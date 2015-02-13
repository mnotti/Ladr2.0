//
//  GroupTableViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/11/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "GroupViewCellTableViewCell.h"
#import "ReportGameViewController.h"

@interface GroupTableViewController : UITableViewController

@property (nonatomic, strong) NSString* currentGroupName; //name that is transferred from the previous view

@property (nonatomic, strong) NSMutableArray* groupMembers; //mutable because it might change while the user is viewing the group

@property (nonatomic, strong) PFObject* currentGroup; //queried for in viewDidLoad

@end
