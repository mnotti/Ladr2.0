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

bool imageSelected = NO;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageChosen.userInteractionEnabled = YES;
    self.imageChosen.image = [UIImage imageNamed:@"anonymous"];
    [self.view bringSubviewToFront:self.imageChosen];
    
    imageSelected = NO;
    
    //SETTING UP TAP RECOGNIZER FOR PIC
    self.imageChosen.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handleTap)];
    tgr.delegate = self;
    [self.imageChosen addGestureRecognizer:tgr];
    
    
    //to remove the keyboard when tapping outside of it
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    


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
    imageSelected = YES; //notifies system that image has been selected and the user can proceed with group creation process
    
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
    else if (!imageSelected)
    {
        self.doneButton.enabled = YES;
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"YOU SHALL NOT PASS..." message:@"...Until you select an image to represent your group" delegate:self cancelButtonTitle:@"Yes Gandalf" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        self.doneButton.enabled = YES;
        [self performSegueWithIdentifier:@"showAddInitialFriends" sender:self];
    }
        
    
   
}//


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




-(void)dismissKeyboard {
    [self.groupNameTextField resignFirstResponder];
    
}



@end
