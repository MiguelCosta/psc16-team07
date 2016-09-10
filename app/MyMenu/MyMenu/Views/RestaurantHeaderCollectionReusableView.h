//
//  RestaurantHeaderCollectionReusableView.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCellProtocol.h"


@class Restaurant;

@interface RestaurantHeaderCollectionReusableView : UICollectionReusableView <CollectionViewCellProtocol>


@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIImageView    * img;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;


- (void)loadRestaurant:(Restaurant *)restaurant;

@end
