//
//  NotificationTableViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/9/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AcceptButton.h"
#import "GlobalVarsTest.h"

@interface NotificationTableViewController : UITableViewController

@property (strong, nonatomic) NSArray* pendingRequests;
@property (strong, nonatomic) NSMutableArray* tempGroups;

@property (strong, nonatomic) PFObject* pendingRequestBeingDisplayed;
@property (strong, nonatomic) PFObject* tempGroup;
@property (strong, nonatomic) PFObject* tempUser;

@property (strong, nonatomic) PFUser* currentUser;

@end
