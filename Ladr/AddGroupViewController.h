//
//  AddGroupViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/6/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AddInitialFriendsViewController.h"
#import "ImageChosenView.h"

@interface AddGroupViewController : UIViewController <UIGestureRecognizerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (strong, nonatomic) NSMutableArray* userGroups;

@property (strong, nonatomic) PFUser* currentUser;


@property (weak, nonatomic) IBOutlet ImageChosenView *imageChosen;
@property (nonatomic) UIImage* imageChosenImage;


@end
