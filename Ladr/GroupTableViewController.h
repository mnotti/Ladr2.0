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
#import "AddFriendsToGroupViewController.h"
#import "GlobalVarsTest.h"

@interface GroupTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;


@property (nonatomic, strong) NSString* winsLosses;

@property (nonatomic, strong) NSArray* groupMembersData; //mutable because it might change while the user is viewing the group

@property (nonatomic, strong) PFObject* currentGroup; //queried for in viewDidLoad
@property (nonatomic, strong) NSString* currentGroupName;

@property (nonatomic, strong) NSMutableArray* visibleCells;


@end
