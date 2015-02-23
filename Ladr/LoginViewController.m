//
//  LoginViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/3/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //hide the back button until the user logs on
    self.navigationItem.hidesBackButton = YES;
    
    //remove keyboard after tap on screen:
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    //end of remove keyboard after screen tap
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButton:(id)sender {
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
        block:^(PFUser *user, NSError *error) {
        if (user)
        {
            // Do stuff after successful login.
            NSLog(@"login successful!");
            [self dismissKeyboard];
                                            
            NSString* pathComponent = [PFUser currentUser][@"username"];
            pathComponent = [pathComponent stringByAppendingString:@"ProfilePic"];
            NSLog(@"path component is : %@", pathComponent);
                                            
            NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *path = [dir stringByAppendingPathComponent:pathComponent];
            if([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
                UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
                GlobalVarsTest *obj=[GlobalVarsTest getInstance];
                obj.profilePic = loadedImage;
            }

            
            //NAVIGATE TO THE HOME SCREEN
            AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
                                            
            appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];

                } else {
                                            // The login failed. Check error to see why.
                NSLog(@"login failed");
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ya done fucked up" message:@"something's incorrect dude" delegate:self cancelButtonTitle:@"geez i'm real sorry man" otherButtonTitles:nil, nil];
                [alert show];
                }
            }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dismissKeyboard {
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
}

@end
