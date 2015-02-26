//
//  SettingsViewController.m
//  Ladr
//
//  Created by Markus Notti on 2/15/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "SettingsViewController.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)showLoginButton:(id)sender {
    NSLog(@"button touched");
    GlobalVarsTest *obj=[GlobalVarsTest getInstance];
    obj.profilePic = nil;
    obj.userGroups = nil;

    [PFUser logOut];
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}
@end
