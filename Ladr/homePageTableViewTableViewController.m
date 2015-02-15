//
//  homePageTableViewTableViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/5/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "homePageTableViewTableViewController.h"

@interface homePageTableViewTableViewController ()

@end

@implementation homePageTableViewTableViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIBarButtonItem *addGroupBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
    UIBarButtonItem *notificationsBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"!" style:UIBarButtonItemStylePlain target:self action:@selector(notificationAction)];
    
    self.navBar.rightBarButtonItems = [[NSArray alloc] initWithObjects:addGroupBarButtonItem, notificationsBarButtonItem, nil];

    PFUser* currentUser = [PFUser currentUser];
    
    self.userGroups = currentUser[@"groups"];
    NSLog(@"%@", [self.userGroups objectAtIndex:0]);
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"TESTING THE MERGE SORT::::::");
//    NSArray* unsortedArray = [[NSArray alloc] initWithObjects:@"markus", @270, @2, @4, @"bob", @420, @4, @5, @"the worst", @220, @1, @5, @"swag", @700, @7, @5, @"The best", @900, @10, @0, @"ALSO the worst", @220, @1, @6, @"not as swag", @600, @7, @6, @"second best", @890, @9, @1,  nil];
//    NSArray* sorted = [self mergeSort:unsortedArray];
//    NSLog(@"SORTED ARRAY BE LIKE: %@", sorted);
    
    //testing if we can access groups
//    PFUser* currentUser = [PFUser currentUser];
//    
//    self.userGroups = currentUser[@"groups"];
//    NSLog(@"%@", [self.userGroups objectAtIndex:0]);
    //testing over
    
    
    
    
        // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.userGroups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainScreenCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.userGroups objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath     *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    /////////////////////////////////////////////////
    
    /////////////////////////////////
    long indexInt = indexPath.row;

    [self performSegueWithIdentifier:@"showGroup" sender:self];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([[segue identifier] isEqualToString:@"showGroup"])
     {
         GroupTableViewController *groupViewController = [segue destinationViewController];
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         groupViewController.currentGroupName = [self.userGroups objectAtIndex:indexPath.row];
     }
 }

#pragma mark - buttons
- (void)addAction{
    [self performSegueWithIdentifier:@"showAddGroupController" sender:self];
    
}

-(void)notificationAction{
    [self performSegueWithIdentifier:@"showNotificationTable" sender:self];
}





@end
