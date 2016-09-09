//
//  RestaurantCollectionViewCell.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCellProtocol.h"


@class Restaurant, WishlistHandler;

@interface RestaurantCollectionViewCell : UICollectionViewCell <CollectionViewCellProtocol>


@property (weak, nonatomic) IBOutlet UIImageView    * restaurantImg;
@property (weak, nonatomic) IBOutlet UIButton       * btWishlist;
@property (weak, nonatomic) IBOutlet UILabel        * lblName;
@property (weak, nonatomic) IBOutlet UILabel        * lblDescription;
@property (weak, nonatomic) IBOutlet UIView *containerView;


- (void)loadRestaurant:(Restaurant *)restaurant withWishlistHandler:(WishlistHandler *)wishlistHandler;

@end
