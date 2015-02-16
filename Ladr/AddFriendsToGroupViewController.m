//
//  AddFriendsToGroupViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/15/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "AddFriendsToGroupViewController.h"

@interface AddFriendsToGroupViewController ()

@end

@implementation AddFriendsToGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize arrays
    self.cellsSelected = [NSMutableArray array];
    self.usersSelected = [[NSMutableArray alloc] init];
    self.potentialFriends = [[NSMutableArray alloc] init];
    
    //get current user
    PFUser *currentUser = [PFUser currentUser];
    self.currentUser = currentUser;
    
    //Get Users not in the group
    PFRelation* membersRelation = [self.currentGroup relationForKey:@"membersRelation"];
    PFQuery* queryForGroupMembers = [membersRelation query];
    [queryForGroupMembers findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSMutableArray* groupMemberIds = [[NSMutableArray alloc] init];
        NSArray* groupMembers = objects;
            
        PFQuery* queryForFriends = [PFUser query];  //query for all users

        [queryForFriends orderByDescending:@"username"];
        [queryForFriends findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSArray* allUsers = objects;
            for(PFUser* user in allUsers)
            {
                if ([groupMembers containsObject:user])
                {}
                else{
                    [self.potentialFriends addObject:user];
                }
            }
            NSLog(@"self.potentialFriends: %@", self.potentialFriends);
            [self.addFriendsTableView reloadData];
        }];

    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewShit
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [self.potentialFriends count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath     *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    /////////////////////////////////////////////////
    
    /////////////////////////////////
    long indexInt = indexPath.row;
    
    
    //if (cell.accessoryType == UITableViewCellAccessoryNone) //if there's no check
    if (![self.cellsSelected containsObject:indexPath])
    {
        [self.cellsSelected addObject:indexPath];
        
        [self.usersSelected addObject: [self.potentialFriends objectAtIndex:indexInt]];
        NSLog(@"User selected to be added to array: %@", [self.potentialFriends objectAtIndex:indexInt]);
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //add a check
        
    }
    else  //if there's a check already
    {
        [self.cellsSelected removeObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone; //take away check
        
        [self.usersSelected removeObject: [self.potentialFriends objectAtIndex:indexInt]];
        
    }
    [self.addFriendsTableView reloadData];
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    Region *region = [regions objectAtIndex:section];
//    return [region name];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"addFriendsTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier]];
    //    }
    
    if ([self.cellsSelected containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    self.friendBeingDisplayed = [self.potentialFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = self.friendBeingDisplayed[@"username"];
    return cell;
}


- (IBAction)doneButton:(id)sender {
    if([self.usersSelected count] == 0)
    {
        //self.doneButton.enabled =YES;
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Hmmmm..." message:@"You didn't select any friends to add" delegate:self cancelButtonTitle:@"Oh woah is me" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    else //if group is ready to be added
    {
        for (PFUser* userToRequest in self.usersSelected)
        {
            PFObject* newGroupRequest = [PFObject objectWithClassName:@"GroupRequest"];
            newGroupRequest[@"from"] = self.currentUser;
            newGroupRequest[@"to"] = userToRequest;
            newGroupRequest[@"group"] = self.currentGroup;
            newGroupRequest[@"groupName"] = self.currentGroup[@"name"];
            [newGroupRequest saveInBackground];
            NSLog(@"one request saved");
                    
        }
                
        
        [self.navigationController popViewControllerAnimated:YES];
    }
            
          

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
