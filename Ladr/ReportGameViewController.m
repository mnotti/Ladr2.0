//
//  ReportGameViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/12/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "ReportGameViewController.h"

@interface ReportGameViewController ()

@end

@implementation ReportGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize to -1 (no cell selected)
    rowWithSelectedCell = -1;
    [self.opponentsTableView reloadData];
    
    //to remove the keyboard when tapping outside of it
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
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
    return [self.opponentsPotential count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath     *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    /////////////////////////////////////////////////
    
    /////////////////////////////////
    long indexInt = indexPath.row;
    
    
    //if (cell.accessoryType == UITableViewCellAccessoryNone) //if there's no check
    if (!rowWithSelectedCell == indexInt)
    {
        rowWithSelectedCell = indexInt;
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //add a check
        
    }
    else  //if there's a check already
    {
        rowWithSelectedCell = -1;
        cell.accessoryType = UITableViewCellAccessoryNone; //take away check
        
    }
    [tableView reloadData];
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    Region *region = [regions objectAtIndex:section];
//    return [region name];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"reportGameOpponentCell";
    UITableViewCell *cell = [self.opponentsTableView dequeueReusableCellWithIdentifier:MyIdentifier];
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier]];
    //    }
    
    if (rowWithSelectedCell == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    cell.textLabel.text = self.opponentsPotential[indexPath.row];
    return cell;
}

-(void)dismissKeyboard {
    [self.yourScoreField resignFirstResponder];
    [self.opponentScoreField resignFirstResponder];

    
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
