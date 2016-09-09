//
//  RestaurantFooterCollectionReusableView.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCellProtocol.h"



@class Restaurant, MKMapView;

@interface RestaurantFooterCollectionReusableView : UICollectionReusableView <CollectionViewCellProtocol>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void)updateRestaurantPosition:(Restaurant *)restaurant;

@end
