//
//  ViewController.m
//  Ladr
//
//  Created by Markus Notti on 1/31/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "mainScreenVC.h"

@interface mainScreenVC ()

@end

@implementation mainScreenVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
