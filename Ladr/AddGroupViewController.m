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
    
    PFUser *currentUser = [PFUser currentUser];
    self.currentUser = currentUser;
    self.userGroups = currentUser[@"groups"];
    
    PFQuery* queryForFriends = [PFUser query];
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
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createNewGroupRequest:(id)sender {
    if ([self.userGroups containsObject: self.groupNameTextField.text])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Try a New Name" message:@"You are already in a group with that name" delegate:self cancelButtonTitle:@"I am a fool" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [self.userGroups insertObject:self.groupNameTextField.text atIndex:0];
        self.currentUser [@"groups"] = self.userGroups;
        [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
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
    self.friendBeingDisplayed = [self.potentialFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = self.friendBeingDisplayed[@"username"];
    return cell;
}

@end
