//
//  NotificationTableViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/9/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "NotificationTableViewController.h"

@interface NotificationTableViewController ()

@end

@implementation NotificationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pendingRequests = NULL;
    self.tempGroups = [[NSMutableArray alloc] init];
    self.currentUser = [PFUser currentUser];
    

    
    //////////////////////////////////////////////////
    //WHERE I GET ALL THE GROUPREQUESTS FOR THE USER//
    //AND ALL THE GROUPS IN THOSE REQUESTS////////////
    //////////////////////////////////////////////////
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"GroupRequest"];
    [query2 whereKey:@"to" equalTo:[PFUser currentUser]];
    [query2 includeKey:@"group"];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects)
        {
            NSLog(@"%@", object[@"group"]/*[@"name"]*/);
            [self.tempGroups insertObject:object[@"group"]/*[@"name"]*/ atIndex:0];
        }
        NSLog(@"%@", self.tempGroups);
        self.pendingRequests = objects;
        [self.tableView reloadData];
                  }];
    //////////////////////////////////////////////////
    //////////////////////////////////////////////////
    
    
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
    return [self.tempGroups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
    

    
    ////////////////////////////////////////////////////
    //MAKING THE ACCEPT BUTTON//////////////////////////
    ////////////////////////////////////////////////////
    AcceptButton *yourBtn = [[AcceptButton alloc] initWithFrame:CGRectMake(0,0, 40, 40)];
    [yourBtn setImage:[UIImage imageNamed:@"gradientButton1"] forState:UIControlStateNormal];
    [yourBtn addTarget:self action:@selector(acceptButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    yourBtn.row = indexPath.row; //this saves the row in the button
    ////////////////////////////////////////////////////
    
    cell.accessoryView = yourBtn;
    cell.textLabel.text = [self.tempGroups objectAtIndex:indexPath.row][@"name"];


    return cell;
}



- (void) acceptButtonPressed:(id) sender{
    AcceptButton *but = (AcceptButton*) sender; //row number is transferred in the sending button


    self.pendingRequestBeingDisplayed = self.pendingRequests[but.row];
    
    //adds the group name to the user array of groups
    [self.currentUser addUniqueObject:self.tempGroups[but.row][@"name"] forKey:@"groups"];
    [self.currentUser saveInBackground];
    
    //adds the relation to the group's list of users
    PFRelation *relation = [self.tempGroups[but.row] relationforKey:@"membersRelation"];
    [relation addObject:self.currentUser];
    
    //adds the username of the user to the group's members Array for easy access to members
//    [self.tempGroups[but.row] addUniqueObject:self.currentUser[@"username"] forKey:@"memberData"];
//    [self.tempGroups[but.row] addObject:@500 forKey:@"memberData"];
//    [self.tempGroups[but.row] addObject:@0 forKey:@"memberData"];
//    [self.tempGroups[but.row] addObject:@0 forKey:@"memberData"];
    NSMutableArray* tempGroupToAddTo = self.tempGroups[but.row][@"memberData"];
    [tempGroupToAddTo addObject:self.currentUser[@"username"]];
    [tempGroupToAddTo addObject:@500 ];
    [tempGroupToAddTo addObject:@0 ];
    [tempGroupToAddTo addObject:@0];
    self.tempGroups[but.row][@"memberData"] = tempGroupToAddTo;


    //update group
    [self.tempGroups[but.row] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        GlobalVarsTest *obj=[GlobalVarsTest getInstance];
        [obj.userGroups insertObject:(self.tempGroups[but.row]) atIndex:0];
    }];


    
    [self.pendingRequestBeingDisplayed deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.tableView reloadData];

    }];
    
    
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Group Joined" message:@"Succesfully joined...congratulations you can press buttons" delegate:self cancelButtonTitle:@"Sweet! I guess I'm cool now" otherButtonTitles:nil, nil];
    [alert show];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
