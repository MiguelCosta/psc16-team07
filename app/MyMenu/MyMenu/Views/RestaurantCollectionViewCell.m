//
//  RestaurantCollectionViewCell.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "RestaurantCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Restaurant.h"
#import "UILabelCustomization.h"
#import <ChameleonFramework/Chameleon.h>
#import "WishlistHandler.h"
#import "AnimationHelper.h"


@interface RestaurantCollectionViewCell ()


@property (nonatomic, strong) Restaurant        * restaurant;
@property (nonatomic, strong) WishlistHandler   * wishlistHandler;


@end

@implementation RestaurantCollectionViewCell


#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"RestaurantCellView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"Restaurant";
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.containerView.layer.cornerRadius = 2.0;
    self.containerView.backgroundColor = [[UIColor flatWhiteColor] colorWithAlphaComponent:0.9];
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    [self resetImage];
}

- (void)resetImage {
    
    [self.restaurantImg cancelImageDownloadTask];
    self.restaurantImg.image = nil;
}

- (void)loadRestaurant:(Restaurant *)restaurant withWishlistHandler:(WishlistHandler *)wishlistHandler {
    
    self.wishlistHandler = wishlistHandler;
    self.restaurant = restaurant;
    
    self.lblName.attributedText = [UILabelCustomization defaultAttributedTextForLabelWithText:restaurant.name];
    self.lblDescription.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:restaurant.type];
    
    [self.btWishlist setSelected:[self.wishlistHandler checkIfRestaurantIsOnWishlist:restaurant]];
    
    [self.restaurantImg setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mymenuapi.azurewebsites.net/api/Restaurants/%@/Photo", [restaurant.key stringValue]]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if (response == nil && image) {
            self.restaurantImg.image = image;
            self.restaurantImg.backgroundColor = [UIColor whiteColor];
        }else {
            if (image) {
                self.restaurantImg.backgroundColor = [UIColor whiteColor];
                [UIView transitionWithView:self.restaurantImg
                                  duration:0.3
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    self.restaurantImg.image = image;
                                }
                                completion:NULL];
            }
        }
    } failure:nil];
}

#pragma mark - IBActions
- (IBAction)wishlistAction:(id)sender {
    
    [AnimationHelper bounceButton:sender];
    [self.wishlistHandler addOrRemoveFromWishlistRestaurant:self.restaurant fromSender:sender];
}

@end
