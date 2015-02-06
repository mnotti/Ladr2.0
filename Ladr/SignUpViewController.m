//
//  SignUpViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/3/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signUpButton:(id)sender {
    NSString* username = [self.usernameField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* password = self.passwordField1.text;
    NSString* passwordConfirm = self.passwordFieldConfirm.text;
    NSLog(@"%@", password);
    NSLog(@"%@", passwordConfirm);
    if ([username length] == 0)
    {
        UIAlertView* usernameLength = [[UIAlertView alloc] initWithTitle: @"Shucks!" message:@"You need to enter a username!" delegate:(self) cancelButtonTitle: @"I promise to do better this time" otherButtonTitles:nil];
        [usernameLength show];
        
    }
    else if ([password length] < 4)
    {
        UIAlertView* passwordLength = [[UIAlertView alloc] initWithTitle: @"Shucks!" message:@"Your Password is too short!" delegate:(self) cancelButtonTitle: @"I promise to do better this time" otherButtonTitles:nil];
        [passwordLength show];
    }
    else if ([password compare:passwordConfirm] != NSOrderedSame)
    {
        UIAlertView* passwordMismatch = [[UIAlertView alloc] initWithTitle: @"Shucks!" message:@"Your passwords don't match!" delegate:(self) cancelButtonTitle: @"I promise to do better this time" otherButtonTitles:nil];
        [passwordMismatch show];
    }
    else
    {
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        //user.email = @"email@example.com";
        
        // other fields can be set just like with PFObject
        //user[@"phone"] = @"415-392-0202";
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error)
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                NSString *errorString = [error userInfo][@"error"];
                UIAlertView* passwordMismatch = [[UIAlertView alloc] initWithTitle: @"Shucks!" message:errorString delegate:(self) cancelButtonTitle: @"I promise to do better this time" otherButtonTitles:nil];
                [passwordMismatch show];
                
                // Show the errorString somewhere and let the user try again.
            }
        }];
    }
    


}

-(void)dismissKeyboard {
    [self.passwordFieldConfirm resignFirstResponder];
    [self.passwordField1 resignFirstResponder];
    [self.usernameField resignFirstResponder];
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
