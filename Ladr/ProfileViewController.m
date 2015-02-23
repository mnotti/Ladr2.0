//
//  ProfileViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/22/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    
    //TESTING GLOBAL VARS
//    GlobalVarsTest *obj=[GlobalVarsTest getInstance];
//    obj.str= @"I am Global variable";
    
    //SETS UP BACK BUTTON
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
    // Do any additional setup after loading the view.
    
    //SETTING USERNAME
    self.usernameField.text = [PFUser currentUser][@"username"];
    
    
    //SETTING UP TAP RECOGNIZER FOR PIC
    self.profilePicImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handleTap)];
    tgr.delegate = self;
    [self.profilePicImageView  addGestureRecognizer:tgr];
    
#pragma mark- to be fixed later (initialize to actual profile pic)
    //INITIALIZING PROFILE PIC (WILL BE ACTUAL PIC LATER)
    self.profilePicImageView.image = [UIImage imageNamed:@"anonymous"];
    [self.view bringSubviewToFront:self.profilePicImageView];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    GlobalVarsTest *obj=[GlobalVarsTest getInstance];
    
    NSLog(@"view did appear is running");
    if (obj.profilePic)
    {
        NSLog(@"there is a profile pic stored in the data controller");
        self.profilePicImageView.image = obj.profilePic;
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
    
    
    //saving image chosen
   
    self.profilePicImageView.image = chosenImage;
    GlobalVarsTest *obj=[GlobalVarsTest getInstance];
    obj.profilePic = self.profilePicImageView.image;
    
     NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [dir stringByAppendingPathComponent:@"profilePic.png"];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImagePNGRepresentation(chosenImage)];
        [myFileHandle closeFile];

    }
    else if([[NSFileManager defaultManager] createFileAtPath:path
                                                    contents:nil attributes:nil])
    {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImagePNGRepresentation(chosenImage)];
        [myFileHandle closeFile];

    }
    else{
        NSLog(@"Error creating file %@", path);

    }
    
    
    //self.imageChosenImage = chosenImage;
    
    NSLog(@"image chosen bam!");
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
