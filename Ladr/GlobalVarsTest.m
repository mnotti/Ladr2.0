//
//  GlobalVarsTest.m
//  Ladr
//
//  Created by Markus Notti on 2/22/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "GlobalVarsTest.h"

@implementation GlobalVarsTest
@synthesize profilePic;

static GlobalVarsTest *instance = nil;

+(GlobalVarsTest *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [GlobalVarsTest new];
        }
    }
    return instance;
}
@end
