//
//  DishHeaderCollectionReusableView.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "DishHeaderCollectionReusableView.h"
#import "UILabelCustomization.h"

@implementation DishHeaderCollectionReusableView

#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"DishHeaderView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"DishHeader";
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.lblTitle.attributedText = [UILabelCustomization defaultAttributedRedTitleForLabelWithText:@"Dishes"];
    self.lblTitle.textColor = [UIColor whiteColor];
}
@end
