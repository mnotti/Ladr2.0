//
//  SettingsViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/15/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "GlobalVarsTest.h"
#import <Parse/Parse.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
- (IBAction)showLoginButton:(id)sender;


@end
