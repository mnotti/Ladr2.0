//
//  PanelTableViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/15/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "GlobalVarsTest.h"

@interface PanelViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *panelTableView;
@property (strong, nonatomic) NSArray* menuArray;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end
