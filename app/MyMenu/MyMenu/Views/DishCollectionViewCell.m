//
//  DishCollectionViewCell.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "DishCollectionViewCell.h"


@implementation DishCollectionViewCell


#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"DishCellView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"Dish";
}


@end
