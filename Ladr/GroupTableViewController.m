//
//  GroupTableViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/11/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "GroupTableViewController.h"

@interface GroupTableViewController ()

@end

@implementation GroupTableViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:(BOOL)animated];
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    [query whereKey:@"name" equalTo:self.currentGroupName];
    [query whereKey:@"membersRelation" equalTo:[PFUser currentUser]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (error)
        {
            NSLog(@"something went wrong, query could not find group selected");
            
        }
        else
        {
            self.currentGroup = object;
            self.groupMembersData = self.currentGroup[@"memberData"];
            NSLog(@"members in this group are: %@", self.groupMembersData);
            self.groupMembersData = [self mergeSort:self.groupMembersData];
            [self.tableView reloadData];
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 44;
    
    
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
    NSLog(@"groupMembers count = %lu", ((unsigned long)[self.groupMembersData count] / 4));
    return ([self.groupMembersData count] / 4);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.memberRank.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.memberUsername.text = [self.groupMembersData objectAtIndex:(indexPath.row * 4)];
    cell.memberRating.text = [NSString stringWithFormat:@"%@", [self.groupMembersData objectAtIndex:(indexPath.row * 4) + 1]];
    
    
    
    return cell;
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
    
    ReportGameViewController *reportViewController = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"showReportScore"])
    {
        if ([self.groupMembersData count] > 4){
        reportViewController.currentGroup = self.currentGroup;
            reportViewController.opponentsPotentialData = (NSMutableArray*) self.groupMembersData;
            
        
//        NSMutableArray *opponentsData = self.groupMembersData;
//        NSLog(@"opponentData before transition: %@", opponentsData);
//        
//        long indexToRemove = [opponentsData indexOfObject:[PFUser currentUser][@"username"]];
//        [opponentsData removeObjectAtIndex:indexToRemove];
//        
//        [opponentsData removeObjectAtIndex:indexToRemove + 1];
//        NSLog(@"index2: %ld", indexToRemove + 1);
//
//        [opponentsData removeObjectAtIndex:indexToRemove + 2];
//         NSLog(@"index3: %ld", indexToRemove + 2);
//        
//        [opponentsData removeObjectAtIndex:indexToRemove + 3];
//        NSLog(@"index4: %ld", indexToRemove + 3);
//        
//        reportViewController.opponentsPotentialData = opponentsData;
            
        }
        else{
            reportViewController.opponentsPotentialData = nil;
            reportViewController.currentGroup = self.currentGroup;

            
        }
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


@end
