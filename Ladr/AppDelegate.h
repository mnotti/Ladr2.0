//
//  AppDelegate.h
//  Ladr
//
//  Created by Markus Notti on 1/31/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.

//  Testing first commit

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GlobalVarsTest.h"
//#import <FacebookSDK/FacebookSDK.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

