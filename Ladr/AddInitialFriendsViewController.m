//
//  AddInitialFriendsViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/16/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "AddInitialFriendsViewController.h"

@interface AddInitialFriendsViewController ()


@end



@implementation AddInitialFriendsViewController

@synthesize filteredFriendsArray;
@synthesize friendsSearchBar, initialFriendsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _isFiltered = NO;
    self.potentialFriendsNames = [[NSMutableArray alloc] init];
    
    
    
//    //to remove the keyboard when tapping outside of it
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    tap.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tap];
    

    
    //initialize arrays
    self.cellsSelected = [NSMutableArray array];
    self.usersSelected = [[NSMutableArray alloc] init];
    self.usersSelectedNames = [[NSMutableArray alloc] init];
    
    //setup and initialize current user
    PFUser *currentUser = [PFUser currentUser];
    self.currentUser = currentUser;
    
   
    
    
    /////////////////////////////////////////////////////////////////////////////////////
    //MAKE THIS A MORE DETAILED QUERY IN THE FUTURE//////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    
    PFQuery* queryForFriends = [PFUser query];  //query for all users
    [queryForFriends orderByAscending:@"username"];
    [queryForFriends findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error)
        {
            self.potentialFriends = objects;
            NSLog(@"potential friends after query: %@", self.potentialFriends);
            //to initialize filtered array
            //self.filteredFriendsArray  = [NSMutableArray arrayWithCapacity:[self.potentialFriends count]];
            for (int i = 0; i < [self.potentialFriends count]; i++)
               [ self.potentialFriendsNames addObject:(self.potentialFriends[i][@"username"]) ];
            NSLog(@"potential friends names after query: %@", self.potentialFriendsNames);

            [self.initialFriendsTableView reloadData];
        }
        else{
            NSLog(@"error querying for users");
        }
    }];
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - TableViewShit
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    if (_isFiltered)
        return [self.filteredFriendsArray count];
    else
        return [self.potentialFriends count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    /////////////////////////////////////////////////
    
    /////////////////////////////////
    //long indexInt = indexPath.row;
    
    if (![self.usersSelectedNames containsObject:cell.textLabel.text])
    {
        [self.usersSelectedNames addObject:cell.textLabel.text];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else{
        [self.usersSelectedNames removeObject:cell.textLabel.text];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView reloadData];
    
    
//    //if (cell.accessoryType == UITableViewCellAccessoryNone) //if there's no check
//    if (![self.cellsSelected containsObject:indexPath])
//    {
//        [self.cellsSelected addObject:indexPath];
//        
//        [self.usersSelected addObject: [self.potentialFriends objectAtIndex:indexInt]];
//        NSLog(@"User selected to be added to array: %@", [self.potentialFriends objectAtIndex:indexInt]);
//        cell.accessoryType = UITableViewCellAccessoryCheckmark; //add a check
//        
//    }
//    else  //if there's a check already
//    {
//        [self.cellsSelected removeObject:indexPath];
//        cell.accessoryType = UITableViewCellAccessoryNone; //take away check
//        
//        [self.usersSelected removeObject: [self.potentialFriends objectAtIndex:indexInt]];
//        
//    }
//    [tableView reloadData];
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    Region *region = [regions objectAtIndex:section];
//    return [region name];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"addInitialFriendsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier]];
    //    }

    
        if (_isFiltered)
        {
            cell.textLabel.text = [self.filteredFriendsArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text = [self.potentialFriendsNames objectAtIndex:indexPath.row];
            
        }
    if ([self.usersSelectedNames containsObject:cell.textLabel.text])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }

    
    
    return cell;
}

#pragma mark - button pressed
- (IBAction)saveButtonPressed:(id)sender
{
            long indexOfUser;
            for (NSString* name in self.usersSelectedNames)
            {
                indexOfUser = [self.potentialFriendsNames indexOfObject:name];
                [self.usersSelected addObject:[self.potentialFriends objectAtIndex:indexOfUser]];
            }
    
            ////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////
            //CONSIDER MULTITHREADING THIS INSTEAD OF STACKING THEM ONE AFTER THE OTHER////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////
    
            PFObject* newGroup = [PFObject objectWithClassName:@"Group"]; //makes new group object
            newGroup[@"name"] = self.groupNameNew;
            NSArray* tempMembersArray = [[NSArray alloc] initWithObjects:self.currentUser[@"username"], @500, @0, @0, nil];
            newGroup[@"memberData"] = tempMembersArray;
            PFRelation *relation = [newGroup relationForKey:@"membersRelation"]; //adds usr to the group's list of members
    
            [relation addObject:self.currentUser];
    
    // Save the image to Parse
    NSData* data = UIImageJPEGRepresentation(self.groupImage, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
 
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The image has now been uploaded to Parse. Associate it with a new object
            PFObject* newPhotoObject = [PFObject objectWithClassName:@"PhotoObject"];
            [newPhotoObject setObject:imageFile forKey:@"image"];
            
            [newPhotoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [newGroup setObject:imageFile forKey:@"groupImage"];

                    [newGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) //newGroupCreated with initial member being current User
                        {
                            NSLog(@"new group saved");
                            
                            for (PFUser* userToRequest in self.usersSelected)
                            {
                                PFObject* newGroupRequest = [PFObject objectWithClassName:@"GroupRequest"];
                                newGroupRequest[@"from"] = self.currentUser;
                                newGroupRequest[@"to"] = userToRequest;
                                newGroupRequest[@"group"] = newGroup;
                                newGroupRequest[@"groupName"] = self.groupNameNew;
                                [newGroupRequest saveInBackground];
                                NSLog(@"one request saved");
                                
                            }
                            
                            [self.userGroups insertObject:self.groupNameNew atIndex:0]; //adds group to user's group list
                            self.currentUser [@"groups"] = self.userGroups;
                            [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                if (succeeded) //current user's group list updated
                                {
                                    NSLog(@"user saved");
                                    
                                    // self.doneButton.enabled = YES;
                                    NSLog(@"user saved");
                                    [self.navigationController popToRootViewControllerAnimated:YES]; //return to main screen
                                }
                            }];
                            
                        }
                    }];

                }
                else{
                    // Error
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }];
    
    
    GlobalVarsTest *obj=[GlobalVarsTest getInstance];
    [obj.userGroups insertObject:newGroup atIndex:0];
    

    

}

#pragma mark SearchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0)
        _isFiltered = NO;
    else
    {
        _isFiltered = YES;
        self.filteredFriendsArray = [[NSMutableArray alloc] init];
        for (NSString* friend in self.potentialFriendsNames)
        {
            NSRange friendsRange = [friend rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (friendsRange.location != NSNotFound)
            {
                [self.filteredFriendsArray addObject:friend];
            }
        }
    }
    [self.initialFriendsTableView reloadData];
}


#pragma mark - UISearchDisplayController Delegate Methods

-(void)dismissKeyboard {
    //[self.groupNameTextField resignFirstResponder];
    
}

@end
