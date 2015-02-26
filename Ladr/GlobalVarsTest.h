//
//  GlobalVarsTest.h
//  Ladr
//
//  Created by Markus Notti on 2/22/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

// This file is for storing global vars

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface GlobalVarsTest : NSObject {
    
    UIImage *profilePic;
    NSMutableArray* userGroups;
    PFObject* currentGroup;
    
    
}

@property(nonatomic, retain) UIImage *profilePic;
@property(nonatomic, retain) NSMutableArray* userGroups;
@property(nonatomic, retain) PFObject* currentGroup;

+(GlobalVarsTest*)getInstance;

@end

