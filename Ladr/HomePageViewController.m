//
//  homePageTableViewTableViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/5/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "HomePageViewController.h"



@interface HomePageViewController ()

@end

@implementation HomePageViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PFUser* currentUser = [PFUser currentUser];
    
    self.userGroups = currentUser[@"groups"];
    NSLog(@"%@", [self.userGroups objectAtIndex:0]);
    
    
    [self.mainTableView reloadData];
    self.visibleCells  = (NSMutableArray*)[self.mainTableView visibleCells];
    [self animate:1];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // suppose we have a author object, for which we want to get all books
    
    // first we will create a query on the Book object
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    
    // now we will query the authors relation to see if the author object
    // we have is contained therein
    [query whereKey:@"membersRelation" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.actuallyGroups = (NSMutableArray*)objects;
             NSLog(@"groups: %@", objects);
            for (int i = 0; i < [self.actuallyGroups count]; i++)
            {
                NSLog(@"group was saved");
                PFFile *userImageFile = self.actuallyGroups[i][@"imageFile"];
                NSLog(@"file: %@", userImageFile);
                [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        self.groupImages[i] = [UIImage imageWithData:imageData];
                        (NSLog(@"image was saved"));
                        [self.mainTableView reloadData];
                    }
                }];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
   

    UIBarButtonItem *addGroupBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
    UIBarButtonItem *notificationsBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"!" style:UIBarButtonItemStylePlain target:self action:@selector(notificationAction)];
    
    self.navBar.rightBarButtonItems = [[NSArray alloc] initWithObjects:addGroupBarButtonItem, notificationsBarButtonItem, nil];
    
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:nil];
    

    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [sidebarButton setTarget: self.revealViewController];
        [sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
    self.navBar.leftBarButtonItems = [[NSArray alloc] initWithObjects:sidebarButton, nil];
    
    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(simulateButtonTouch)];
//    [tapGestureRecognizer setDelegate:self];
//    [self.view addGestureRecognizer:tapGestureRecognizer];
//    
    

    
    
    
    
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"groups count: %lu", (unsigned long)[self.userGroups count]);
    return [self.userGroups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainScreenCell" forIndexPath:indexPath];
    
    cell.groupName.text = [self.userGroups objectAtIndex:indexPath.row];
    cell.groupImage.image = [self.groupImages objectAtIndex:indexPath.row];
    NSLog(@"image = %@", cell.groupImage.image);
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath     *)indexPath
{
    
    
    /////////////////////////////////////////////////
    
    /////////////////////////////////
    
    [self performSegueWithIdentifier:@"showGroup" sender:self];
    
}

- (void)animate:(NSInteger)index {
    //ONE AT A TIME
//    if ([self.visibleCells count] <= index) {
//        return;
//    }
//    
//    UITableViewCell* aCell = self.visibleCells[index];
//    [aCell setFrame:CGRectMake(320, aCell.frame.origin.y, aCell.frame.size.width, aCell.frame.size.height)];
//    
//    [UIView animateWithDuration:0.35 delay:0 options:0 animations:^{
//        [self.visibleCells[index] setFrame:CGRectMake(0, aCell.frame.origin.y, aCell.frame.size.width, aCell.frame.size.height)];
//    } completion:^(BOOL finished) {
//        [self animate:index + 1];
//    }];
    //ALL SIMULTANEOUSLY
    [[self.mainTableView visibleCells] enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        [cell setFrame:CGRectMake(320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
        [UIView animateWithDuration:0.2 delay:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];}
                         completion:nil];
        
        [UIView animateWithDuration:0.5 animations:^{
            [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
        }];
    }];
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
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
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
