//
//  GroupTableViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/11/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "LeagueViewController.h"

@interface LeagueViewController ()

@end

@implementation LeagueViewController
@synthesize recentGamesTable;

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:(BOOL)animated];
    
    GlobalVarsTest *obj=[GlobalVarsTest getInstance];
    
    self.currentGroup = obj.currentGroup;
    self.groupMembersData = self.currentGroup[@"memberData"];
    
    
    self.groupMembersData   = [self mergeSort:self.groupMembersData];
    
    
    self.currentGroup[@"memberData"] = self.groupMembersData;
    obj.currentGroup = self.currentGroup;
    
    [self.rankingsTableView reloadData];
    [self.recentGamesTable.recentGamesTableView reloadData];

   
    
    
    //TO ANIMATE THE CELLS FLYING IN SIDEWAYS
     //self.visibleCells = (NSMutableArray*)[self.rankingsTableView visibleCells];
    //[self animate:(0)];
    
    
    if ([self.segmentedControl selectedSegmentIndex] == 0)
    {
        [self.rankingsTableView setHidden:NO];
        [self.recentGamesTable.recentGamesTableView setHidden:YES];
        [self.view bringSubviewToFront:self.rankingsTableView];
    }
    else{
        [self.rankingsTableView setHidden:YES];
        [self.recentGamesTable.recentGamesTableView setHidden:NO];
        [self.view bringSubviewToFront:self.recentGamesTable.recentGamesTableView];




    }
    
    //[recentGamesTable.recentGamesTableView setHidden:NO];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"before the reload table");
    [self.recentGamesTable.recentGamesTableView reloadData];
    NSLog(@"after the reload table");

    UIBarButtonItem *reportScoreBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
    UIBarButtonItem *addFriendsBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+ Friends" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendsButton)];
    
    self.navBar.rightBarButtonItems = [[NSArray alloc] initWithObjects:reportScoreBarButtonItem, addFriendsBarButtonItem, nil];
    
    //self.tableView.rowHeight = 44;
    
    
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
    NSLog(@"still running section function");
    return ([self.groupMembersData count] / 4);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.memberRank.text = [NSString stringWithFormat:@"%d)", indexPath.row + 1];
    cell.memberUsername.text = [self.groupMembersData objectAtIndex:(indexPath.row * 4)];
    cell.memberRating.text = [NSString stringWithFormat:@"%@", [self.groupMembersData objectAtIndex:(indexPath.row * 4) + 1]];
    self.winsLosses = [NSString stringWithString:[[self.groupMembersData objectAtIndex:(indexPath.row * 4) + 2] stringValue]];
    self.winsLosses = [self.winsLosses stringByAppendingString:@"/"];
    self.winsLosses = [self.winsLosses stringByAppendingString:[[self.groupMembersData objectAtIndex:(indexPath.row * 4) + 3] stringValue]  ];
    cell.winsLossesField.text = self.winsLosses;
    
    
    
    return cell;
}

- (void)animate:(NSInteger)index {
    //////THIS DOES ONE AT A TIME
    if ([self.visibleCells count] <= index) {
        return;
    }
    
    UITableViewCell* aCell = self.visibleCells[index];
    [aCell setFrame:CGRectMake(320, aCell.frame.origin.y, aCell.frame.size.width, aCell.frame.size.height)];
    
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.visibleCells[index] setFrame:CGRectMake(0, aCell.frame.origin.y, aCell.frame.size.width, aCell.frame.size.height)];
    } completion:^(BOOL finished) {
        [self animate:index + 1];
    }];
    
    ///THIS DOES ALL CELLS SIMULTANEOUSLY
    //    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
    //        [cell setFrame:CGRectMake(320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    //        NSLog(@"idx integer = %d", (int)idx);
    //        [UIView animateWithDuration:0.2 delay:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    //            [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];}
    //                         completion:nil];
    //
    //        [UIView animateWithDuration:0.5 animations:^{
    //            [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    //        }];
    //    }];
}
/////


-(void) addAction{
    [self performSegueWithIdentifier:@"showReportScore" sender:self];
}

-(void) addFriendsButton{
    [self performSegueWithIdentifier:@"showAddFriends" sender:self];
    
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"showReportScore"])
    {
        ReportGameViewController *reportViewController = [segue destinationViewController];
        
        if ([self.groupMembersData count] > 4){
            reportViewController.currentGroup = self.currentGroup;
            reportViewController.opponentsPotentialData = (NSMutableArray*) self.groupMembersData;
            
            
            
            
        }
        else{
            reportViewController.opponentsPotentialData = nil;
            reportViewController.currentGroup = self.currentGroup;
            
            
        }
    }
    else if ([[segue identifier] isEqualToString:@"showAddFriends"])
    {
        AddFriendsToGroupViewController* addFriendsVC = [segue destinationViewController];
        addFriendsVC.currentGroup = self.currentGroup;
    }
    
    
    
}

#pragma mark - algorithms

-(NSArray *)mergeSort:(NSArray *)unsortedArray
{
    if ([unsortedArray count] < 5)
    {
        return unsortedArray;
    }
    long middle = (([unsortedArray count]/2) - (([unsortedArray count]/2)%4));
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, ([unsortedArray count] - middle));
    NSArray *rightArr = [unsortedArray subarrayWithRange:right];
    NSArray *leftArr = [unsortedArray subarrayWithRange:left];
    //Or iterate through the unsortedArray and create your left and right array
    //for left array iteration starts at index =0 and stops at middle, for right array iteration starts at midde and end at the end of the unsorted array
    NSArray *resultArray =[self merge:[self mergeSort:leftArr] andRight:[self mergeSort:rightArr]];
    return resultArray;
}

-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int right = 0;
    int left = 0;
    while (left < [leftArr count] && right < [rightArr count])
    {
        if ([[leftArr objectAtIndex:(left + 1)] intValue] > [[rightArr objectAtIndex:(right + 1)] intValue])
        {
            [result addObject:[leftArr objectAtIndex:left]];
            [result addObject:[leftArr objectAtIndex:left + 1]];
            [result addObject:[leftArr objectAtIndex:left + 2]];
            [result addObject:[leftArr objectAtIndex:left + 3]];
            
            left+=4;
        }
        else
        {
            [result addObject:[rightArr objectAtIndex:right]];
            [result addObject:[rightArr objectAtIndex:right + 1]];
            [result addObject:[rightArr objectAtIndex:right + 2]];
            [result addObject:[rightArr objectAtIndex:right + 3]];
            
            right+=4;
        }
    }
    NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
    NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
    NSArray *newRight = [rightArr subarrayWithRange:rightRange];
    NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}


- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            [self.rankingsTableView setHidden:NO];
            [self.recentGamesTable.recentGamesTableView setHidden:YES];
            [self.view bringSubviewToFront:self.rankingsTableView];

            break;
        case 1:
            [self.rankingsTableView setHidden:YES];
            [self.recentGamesTable.recentGamesTableView setHidden:NO];
            [self.view bringSubviewToFront:self.recentGamesTable.recentGamesTableView];

            break;
        default: 
            break; 
    }
}


@end
