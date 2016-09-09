//
//  RestaurantDetailViewController.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"
#import "RMPZoomTransitionAnimator.h"


@class Restaurant;

@interface RestaurantDetailViewController : AbstractViewController <RMPZoomTransitionAnimating>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


- (instancetype)initWithRestaurant:(Restaurant *)restaurant;

@end
