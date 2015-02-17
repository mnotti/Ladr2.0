//
//  AddInitialFriendsViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/16/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface AddInitialFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>{
    BOOL _isFiltered;
}
@property (weak, nonatomic) IBOutlet UITableView *initialFriendsTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *friendsSearchBar;

@property (strong, nonatomic) NSMutableArray *filteredFriendsArray;
@property (nonatomic, strong) NSMutableArray* potentialFriendsNames;
@property (strong, nonatomic) NSArray* potentialFriends;

@property (strong, nonatomic) NSMutableArray* usersSelected;
@property (strong, nonatomic) NSMutableArray* usersSelectedNames;
@property (strong, nonatomic) NSMutableArray* cellsSelected;


@property (strong, nonatomic) PFUser* friendBeingDisplayed;
@property (strong, nonatomic) PFUser* currentUser;

@property (strong, nonatomic) NSMutableArray* userGroups;

//groupName
@property (strong, nonatomic) NSString* groupNameNew;


@end
