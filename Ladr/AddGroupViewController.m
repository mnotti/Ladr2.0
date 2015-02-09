//
//  AddGroupViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/6/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "AddGroupViewController.h"

@interface AddGroupViewController ()

@end

@implementation AddGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //to remove the keyboard when tapping outside of it
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    

    
    self.cellsSelected = [NSMutableArray array];
    self.usersSelected = [[NSMutableArray alloc] init]; //initialize array

    PFUser *currentUser = [PFUser currentUser]; //setup and initialize current user
    self.currentUser = currentUser;

    if (currentUser[@"groups"]) //if user is in groups already
    {
        self.userGroups = currentUser[@"groups"];
    }
    else    //if user is not in groups currently
    {
        self.userGroups = [[NSMutableArray alloc] init]; //allocate space for groups array
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////////
    //MAKE THIS A MORE DETAILED QUERY IN THE FUTURE//////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////

    PFQuery* queryForFriends = [PFUser query];  //query for all users
    [queryForFriends orderByAscending:@"score"];
    [queryForFriends findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
        if (!error)
        {
            self.potentialFriends = objects;
            [self.friendsTableView reloadData];
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

- (IBAction)createNewGroupRequest:(id)sender //clicking the done button
{
    if ([self.groupNameTextField.text  isEqual: @""]) //if user didn't type any text
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"You literally suck" message:@"You need to enter a group name" delegate:self cancelButtonTitle:@"I am a fool" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if ([self.userGroups containsObject: self.groupNameTextField.text]) //if group already exists
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Try a New Name" message:@"You are already in a group with that name" delegate:self cancelButtonTitle:@"I am a fool" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else //if group is ready to be added
    {
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        //CONSIDER MULTITHREADING THIS INSTEAD OF STACKING THEM ONE AFTER THE OTHER////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////

        PFObject* newGroup = [PFObject objectWithClassName:@"Group"]; //makes new group object
        NSMutableArray* groupMembers = [[NSMutableArray alloc] initWithObjects:self.currentUser, nil];
        newGroup[@"members"] = groupMembers; //adds ggroup with creator as only member
        newGroup[@"name"] = self.groupNameTextField.text;
        [newGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) //newGroupCreated with initial member being current User
            {
                for (PFUser* userToRequest in self.usersSelected)
                {
                    PFObject* newGroupRequest = [PFObject objectWithClassName:@"GroupRequest"];
                    newGroupRequest[@"from"] = self.currentUser;
                    newGroupRequest[@"to"] = userToRequest;
                    newGroupRequest[@"group"] = newGroup;
                    [newGroupRequest saveInBackground];
                    
                }
                [self.userGroups insertObject:self.groupNameTextField.text atIndex:0]; //adds group to user's group list
                self.currentUser [@"groups"] = self.userGroups;
                [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) //current user's group list updated
                    {
                        
                        [self.navigationController popToRootViewControllerAnimated:YES]; //return to main screen
                    }
                }];

            }
        }];
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
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
    [tableView reloadData];
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    Region *region = [regions objectAtIndex:section];
//    return [region name];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"friendsTableCell";
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

-(void)dismissKeyboard {
    [self.groupNameTextField resignFirstResponder];
    
}



@end
