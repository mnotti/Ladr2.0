//
//  ReportGameViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/12/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ReportGameViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    long rowWithSelectedCell;
    long indexOfUser;
    BOOL currentUserPassedFlag;
}

@property (nonatomic, strong) PFObject* currentGroup;

@property (nonatomic, strong) NSMutableArray* opponentsPotentialData;
@property (nonatomic, strong) NSMutableArray* indicesDisplayed;



@property (weak, nonatomic) IBOutlet UITextField *opponentScoreField;
@property (weak, nonatomic) IBOutlet UITextField *yourScoreField;

@property (weak, nonatomic) IBOutlet UITableView *opponentsTableView;




@end
