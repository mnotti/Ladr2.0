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

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:(BOOL)animated];
    self.indicesDisplayed = [[NSMutableArray alloc]init];
    self.opponentsPotentialData = [[NSMutableArray alloc] initWithArray:self.opponentsPotentialData];
    
    
    //currentUserHasNotBeenPassedInTableView
    currentUserPassedFlag = false;

}

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
    return (([self.opponentsPotentialData count] / 4) - 1); // removing 1 because one is the user
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath     *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    

    long indexInt = indexPath.row;
    
    
   //if there's no check
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
    
    if (rowWithSelectedCell == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    if ([self.opponentsPotentialData[(indexPath.row * 4)] isEqualToString: ([PFUser currentUser][@"username"])])
        {
            currentUserPassedFlag = true;
            indexOfUser = indexPath.row * 4;
        }
    if (currentUserPassedFlag)
    {
        cell.textLabel.text = self.opponentsPotentialData[(indexPath.row * 4) + 4];
        [self.indicesDisplayed addObject:@((indexPath.row * 4) + 4)];
  
    }
    else
    {
        cell.textLabel.text = self.opponentsPotentialData[(indexPath.row * 4)];
        [self.indicesDisplayed addObject:@(indexPath.row * 4)];

    }
    return cell;
}

-(void)dismissKeyboard {
    [self.yourScoreField resignFirstResponder];
    [self.opponentScoreField resignFirstResponder];

    
}
- (IBAction)reportGameButtonPressed:(id)sender {
    if (rowWithSelectedCell == -1)
    {
        UIAlertView* alert1 = [[UIAlertView alloc] initWithTitle:@"Cmon dude" message:@"You gots to select an opponent!" delegate:self cancelButtonTitle:@"OK I'll try to suck less" otherButtonTitles: nil];
        [alert1 show];
    }
    else if ([self.opponentScoreField.text isEqualToString: @""] || [self.opponentScoreField.text isEqualToString: @""])
    {
        UIAlertView* alert2 = [[UIAlertView alloc] initWithTitle:@"Cmon dude" message:@"You gots to enter scores!" delegate:self cancelButtonTitle:@"OK I'll try to suck less" otherButtonTitles: nil];
        [alert2 show];
    }
    else
    {
        NSNumber* tempOppIndex = self.indicesDisplayed[rowWithSelectedCell];
        long tempOppIndexLong = [tempOppIndex longValue];
        
        
        
        NSLog(@"USER WITH ROW SELECTED IS %@", self.opponentsPotentialData[tempOppIndexLong]);
        
        NSNumber* opponentOldRating = self.opponentsPotentialData[tempOppIndexLong + 1];
        NSNumber* userOldRating = self.opponentsPotentialData[[self.opponentsPotentialData indexOfObject:[PFUser currentUser][@"username"]]+ 1];
        
        indexOfUser = [self.opponentsPotentialData indexOfObject:[PFUser currentUser][@"username"]];
        long indexOfOpponent = tempOppIndexLong;

        NSLog(@"opponent: %@", opponentOldRating);
        NSLog(@"user: %@",userOldRating);
        if ([self.opponentScoreField.text intValue] > [self.yourScoreField.text intValue]) //if user loses
        {
            //WINS, LOSSES
            NSNumber *tempOppWins = self.opponentsPotentialData[indexOfOpponent + 2];
            float newOppWins = [tempOppWins floatValue] + 1;
            NSNumber *tempUserLosses = self.opponentsPotentialData[indexOfUser + 3];
            float newUserLosses = [tempUserLosses floatValue] + 1;
            
            [self.opponentsPotentialData replaceObjectAtIndex:(indexOfUser + 3) withObject:[NSNumber numberWithFloat: newUserLosses]];
            [self.opponentsPotentialData replaceObjectAtIndex:(indexOfOpponent + 2) withObject:[NSNumber numberWithFloat:newOppWins]];
            
            //RATINGS
            NSNumber *tempUserRating = self.opponentsPotentialData[indexOfUser + 1];
            NSNumber *tempOppRating = self.opponentsPotentialData[indexOfOpponent + 1];
            
            long oldUserRating = [tempUserRating longValue];
            long oldOppRating = [tempOppRating longValue];
            
            long ratings[2] = {oldOppRating, oldUserRating};
            [self ratingsTest:ratings];
            
            [self.opponentsPotentialData replaceObjectAtIndex:indexOfUser + 1 withObject:[NSNumber numberWithLong: ratings[1]]];
            [self.opponentsPotentialData replaceObjectAtIndex:indexOfOpponent + 1 withObject:[NSNumber numberWithLong:ratings[0]]];
            
            
            
            self.currentGroup[@"memberData"] = self.opponentsPotentialData;
            [self.currentGroup saveInBackground];
        }
        else if ([self.opponentScoreField.text intValue] < [self.yourScoreField.text intValue])//if user wins
        {
            //WINS, LOSSES
            NSNumber *tempUserWins = self.opponentsPotentialData[indexOfUser + 2];
            float newUserWins = [tempUserWins floatValue] + 1;
            NSNumber *tempOppLosses = self.opponentsPotentialData[indexOfOpponent + 3];
            float newOppLosses = [tempOppLosses floatValue] + 1;
            
            [self.opponentsPotentialData replaceObjectAtIndex:(indexOfOpponent + 3) withObject:[NSNumber numberWithFloat: newOppLosses]];
            [self.opponentsPotentialData replaceObjectAtIndex:(indexOfUser + 2) withObject:[NSNumber numberWithFloat:newUserWins]];
            
            //RATINGS
            
            
            NSNumber *tempUserRating = self.opponentsPotentialData[indexOfUser + 1];
            NSNumber *tempOppRating = self.opponentsPotentialData[indexOfOpponent + 1];
            
            long oldUserRating = [tempUserRating longValue];
            long oldOppRating = [tempOppRating longValue];
            
            long ratings[2] = {oldUserRating, oldOppRating};
            [self ratingsTest:ratings];
            
            [self.opponentsPotentialData replaceObjectAtIndex:indexOfUser + 1 withObject:[NSNumber numberWithLong: ratings[0]]];
            [self.opponentsPotentialData replaceObjectAtIndex:indexOfOpponent + 1 withObject:[NSNumber numberWithLong:ratings[1]]];

            
            self.currentGroup[@"memberData"] = self.opponentsPotentialData;
            
            [self.currentGroup saveInBackground];
      
        }

        GlobalVarsTest *obj=[GlobalVarsTest getInstance];
        obj.currentGroup = self.currentGroup;
        NSLog(@"current group loaded to global: %@", self.currentGroup);

        [self.navigationController popViewControllerAnimated:YES];

    }
}
#pragma mark - algorithms
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
