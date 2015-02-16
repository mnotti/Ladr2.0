//
//  AddFriendsToGroupViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/15/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddFriendsToGroupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* usersSelected;
@property (strong, nonatomic) NSMutableArray* cellsSelected;

@property (strong, nonatomic) NSMutableArray* potentialFriends;

@property (strong, nonatomic) PFUser* friendBeingDisplayed;
@property (strong, nonatomic) PFUser* currentUser;

@property (nonatomic, strong) PFObject* currentGroup;

@property (weak, nonatomic) IBOutlet UITableView *addFriendsTableView;

@end
