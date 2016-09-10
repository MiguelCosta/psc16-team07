//
//  WishlistViewController.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"
#import "RMPZoomTransitionAnimator.h"


@interface WishlistViewController : AbstractViewController <RMPZoomTransitionAnimating>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
