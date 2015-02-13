//
//  GroupViewCellTableViewCell.h
//  Ladr
//
//  Created by Markus Notti on 2/12/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupViewCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *memberRating;
@property (weak, nonatomic) IBOutlet UILabel *memberUsername;
@property (weak, nonatomic) IBOutlet UILabel *memberRank;

@end
