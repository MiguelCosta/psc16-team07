//
//  DishCollectionViewCell.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCellProtocol.h"


@class Dish;

@interface DishCollectionViewCell : UICollectionViewCell <CollectionViewCellProtocol>

@property (weak, nonatomic) IBOutlet UIView             * containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * contraint;
@property (weak, nonatomic) IBOutlet UILabel            * lblPrice;
@property (weak, nonatomic) IBOutlet UILabel            * lblName;
@property (weak, nonatomic) IBOutlet UILabel            * lblDescription;
@property (weak, nonatomic) IBOutlet UIImageView *img;


- (void)loadDish:(Dish *)dish;

@end
