//
//  ProfileViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/22/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "GlobalVarsTest.h"

@interface ProfileViewController : UIViewController <UIGestureRecognizerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UILabel *usernameField;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;


@end
