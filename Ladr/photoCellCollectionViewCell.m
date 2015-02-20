//
//  photoCellCollectionViewCell.m
//  Ladr
//
//  Created by Markus Notti on 2/19/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "photoCellCollectionViewCell.h"

@implementation photoCellCollectionViewCell

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] init];
        //self.imageView.image = [UIImage imageNamed:@"ladrLogo1"];
        [self.contentView addSubview:self.imageView];

    }
    return self;
}
-(void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end
