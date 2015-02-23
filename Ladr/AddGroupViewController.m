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
    
    self.imageChosen.userInteractionEnabled = YES;
    self.imageChosen.image = [UIImage imageNamed:@"anonymous"];
    [self.view bringSubviewToFront:self.imageChosen];
    
    //SETTING UP TAP RECOGNIZER FOR PIC
    self.imageChosen.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handleTap)];
    tgr.delegate = self;
    [self.imageChosen addGestureRecognizer:tgr];
    //[tgr release];
    
    
    //to remove the keyboard when tapping outside of it
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    

    //initialize arrays
    //self.cellsSelected = [NSMutableArray array];
    //self.usersSelected = [[NSMutableArray alloc] init];

    //setup and initialize current user
    PFUser *currentUser = [PFUser currentUser];
    self.currentUser = currentUser;

    if (currentUser[@"groups"]) //if user is in groups already
    {
        self.userGroups = currentUser[@"groups"];
    }
    else    //if user is not in groups currently
    {
        self.userGroups = [[NSMutableArray alloc] init]; //allocate space for groups array
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleTap{
    [self selectPhoto];
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageChosen.image = chosenImage;
    self.imageChosenImage = chosenImage;
    
    NSLog(@"image chosen bam!");
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)createNewGroupRequest:(id)sender //clicking the done button
{
    self.doneButton.enabled = NO;
    if ([self.groupNameTextField.text  isEqual: @""]) //if user didn't type any text
    {
        self.doneButton.enabled =YES;
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"You literally suck" message:@"You need to enter a group name" delegate:self cancelButtonTitle:@"I am a fool" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if ([self.userGroups containsObject: self.groupNameTextField.text]) //if group already exists
    {
        self.doneButton.enabled =YES;
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Try a New Name" message:@"You are already in a group with that name" delegate:self cancelButtonTitle:@"I am a fool" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [self performSegueWithIdentifier:@"showAddInitialFriends" sender:self];
    }
        
    
   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showAddInitialFriends"])
    {
        AddInitialFriendsViewController *nextVC = [segue destinationViewController];
        nextVC.groupNameNew = self.groupNameTextField.text;
        nextVC.userGroups = self.userGroups;
        nextVC.groupImage = self.imageChosenImage;
    }
    
}


//#pragma mark - TableViewShit
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Number of rows is the number of time zones in the region for the specified section.
//    return [self.potentialFriends count];
//}

//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath     *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    /////////////////////////////////////////////////
//    
//    /////////////////////////////////
//    long indexInt = indexPath.row;
//
//    
//    //if (cell.accessoryType == UITableViewCellAccessoryNone) //if there's no check
//    if (![self.cellsSelected containsObject:indexPath])
//    {
//        [self.cellsSelected addObject:indexPath];
//        
//        [self.usersSelected addObject: [self.potentialFriends objectAtIndex:indexInt]];
//        NSLog(@"User selected to be added to array: %@", [self.potentialFriends objectAtIndex:indexInt]);
//        cell.accessoryType = UITableViewCellAccessoryCheckmark; //add a check
//        
//    }
//    else  //if there's a check already
//    {
//        [self.cellsSelected removeObject:indexPath];
//        cell.accessoryType = UITableViewCellAccessoryNone; //take away check
//        
//        [self.usersSelected removeObject: [self.potentialFriends objectAtIndex:indexInt]];
//
//    }
//    [tableView reloadData];
//    
//}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    Region *region = [regions objectAtIndex:section];
//    return [region name];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *MyIdentifier = @"friendsTableCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
////    if (cell == nil) {
////        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier]];
////    }
//    
//    if ([self.cellsSelected containsObject:indexPath])
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        
//    }
//    self.friendBeingDisplayed = [self.potentialFriends objectAtIndex:indexPath.row];
//    cell.textLabel.text = self.friendBeingDisplayed[@"username"];
//    return cell;
//}

-(void)dismissKeyboard {
    [self.groupNameTextField resignFirstResponder];
    
}



@end
