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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //FB LOGIN
//    FBLoginView *loginView = [[FBLoginView alloc] init];
//    loginView.center = self.view.center;
//    [self.view addSubview:loginView];
    
    //for testing of ratings

   
    
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

-(void) ratingsTest:(long*)previousRatings{
    //long previousRatings[20] = {100, 150, 200, 250, 300, 350, 400, 200, 200, 400, 700, 500,400, 300, 400, 200, 400, 400, 400, 350};
    //for (int i = 0; i < 20; i += 2)
    //{
        long k = 25;
        long winnerRating = previousRatings[0];
        long loserRating = previousRatings[1];
        long diff = winnerRating - loserRating;
        
        long newWinnerRating;
        long newLoserRating;
        if (winnerRating >= loserRating){
           if (diff < 100 && diff >= 0)
           {
               newLoserRating = loserRating - k;
               newWinnerRating = winnerRating + k;
           }
            else if (diff < 200 && diff >= 100)
            {
                newLoserRating = loserRating - 0.5*k;
                newWinnerRating = winnerRating + 0.5*k;
            }
            else if (diff < 300 && diff >= 200)
            {
                newLoserRating = loserRating - 0.25*k;
                newWinnerRating = winnerRating + 0.25*k;
            }
            else
            {
                newLoserRating = loserRating - 0.125*k;
                newWinnerRating = winnerRating + 0.125*k;
            }
            
        }
        else if (winnerRating < loserRating)
        {
            if (-diff < 100 && -diff >= 0)
            {
                newLoserRating = loserRating - k;
                newWinnerRating = winnerRating + k;
            }
            else if (-diff < 200 && -diff >= 100)
            {
                newLoserRating = loserRating - 2*k;
                newWinnerRating = winnerRating + 2*k;
            }
            else if (-diff < 300 && -diff >= 200)
            {
                newLoserRating = loserRating - 3*k;
                newWinnerRating = winnerRating + 3*k;
            }
            else
            {
                newLoserRating = loserRating - 4*k;
                newWinnerRating = winnerRating + 4*k;
            }
        }
        else
        {
            newWinnerRating = 25 + winnerRating;
            newLoserRating = loserRating - 25;
        }
        NSLog(@"user wins: rating goes from %ld to %ld", winnerRating, newWinnerRating);
        NSLog(@"opp loses: rating goes from %ld to %ld", loserRating, newLoserRating);
    previousRatings[0] = newWinnerRating;
    previousRatings[1] = newLoserRating;
    
        
   // }
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
