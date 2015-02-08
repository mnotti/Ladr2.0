//
//  AddGroupViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/6/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddGroupViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) NSMutableArray* userGroups;
@property (strong, nonatomic) PFUser* currentUser;
@property (strong, nonatomic) NSArray* potentialFriends;
@property (strong, nonatomic) PFUser* friendBeingDisplayed;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;


@end
