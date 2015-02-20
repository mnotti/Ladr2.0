//
//  ChooseGroupPicViewController.h
//  Ladr
//
//  Created by Markus Notti on 2/19/15.
//  Copyright (c) 2015 Markus Notti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseGroupPicViewController : UIViewController <UIImagePickerControllerDelegate>

//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) UIImage* imageChosen;

@end
