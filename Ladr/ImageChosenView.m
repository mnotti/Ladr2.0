//
//  ImageChosenView.m
//  Ladr
//
//  Created by Markus Notti on 2/19/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import "ImageChosenView.h"

@implementation ImageChosenView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image])
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"-- I AM TOUCHED --");
}





@end
