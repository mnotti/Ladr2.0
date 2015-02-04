//
//  SignUpViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/3/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField1;
@property (weak, nonatomic) IBOutlet UITextField *passwordFieldConfirm;

@end
