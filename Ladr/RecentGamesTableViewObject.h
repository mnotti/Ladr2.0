//
//  RecentGamesTableViewObject.h
//  Ladr
//
//  Created by Markus Notti on 2/28/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RecentGamesTableViewObject : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *recentGamesTableView;


@end
