//
//  AddGroupViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/6/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddGroupViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;

@property (strong, nonatomic) NSMutableArray* userGroups;
@property (strong, nonatomic) NSMutableArray* usersSelected;
@property (strong, nonatomic) NSMutableArray* cellsSelected;

@property (strong, nonatomic) NSArray* potentialFriends;

@property (strong, nonatomic) PFUser* friendBeingDisplayed;
@property (strong, nonatomic) PFUser* currentUser;


@end
