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
    
    
}

@property(nonatomic,retain)UIImage *profilePic;

+(GlobalVarsTest*)getInstance;

@end

