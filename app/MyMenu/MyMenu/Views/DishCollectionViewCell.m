//
//  DishCollectionViewCell.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "DishCollectionViewCell.h"
#import <ChameleonFramework/Chameleon.h>
#import "UILabelCustomization.h"
#import "Dish.h"
#import "UIImageView+AFNetworking.h"


@implementation DishCollectionViewCell


#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"DishCellView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"Dish";
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.containerView.backgroundColor = [[UIColor flatWhiteColor] colorWithAlphaComponent:0.9];
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    [self.img setImage:nil];
}

- (void)loadDish:(Dish *)dish {
    
    self.lblPrice.attributedText = [UILabelCustomization defaultBoldAttributedTextForLabelWithText:[NSString stringWithFormat:@"%.2f €", [dish.price floatValue]]];
    
    self.lblName.attributedText = [UILabelCustomization defaultBoldAttributedTextForLabelWithText:dish.name];
    
    self.lblDescription.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:dish.dishDescription];
    
    [self.img setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mymenuapi.azurewebsites.net/api/Dishes/%@/Photo", [dish.key stringValue]]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if (response == nil && image) {
            self.img.image = image;
            self.img.backgroundColor = [UIColor whiteColor];
        }else {
            if (image) {
                self.img.backgroundColor = [UIColor whiteColor];
                [UIView transitionWithView:self.img
                                  duration:0.3
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    self.img.image = image;
                                }
                                completion:NULL];
            }
        }
    } failure:nil];
}


@end
