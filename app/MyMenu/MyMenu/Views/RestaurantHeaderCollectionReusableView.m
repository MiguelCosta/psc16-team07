//
//  RestaurantHeaderCollectionReusableView.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "RestaurantHeaderCollectionReusableView.h"


@implementation RestaurantHeaderCollectionReusableView

#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"RestaurantHeaderReusableView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"Header";
}


@end
