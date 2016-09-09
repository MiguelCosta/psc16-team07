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
    
 //   [self resetImage];
    
    self.containerView.layer.cornerRadius = 2.0;
    
    
  self.containerView.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:self.containerView.frame andColors:[NSArray arrayWithObjects:[UIColor flatWhiteColor], [UIColor clearColor], nil]];
}

- (void)resetImage {
    
    [self.restaurantImg cancelImageDownloadTask];
    self.restaurantImg.image = nil;
}

- (void)loadRestaurant:(Restaurant *)restaurant withWishlistHandler:(WishlistHandler *)wishlistHandler {
    
    self.wishlistHandler = wishlistHandler;
    self.restaurant = restaurant;
    
    self.lblName.attributedText = [UILabelCustomization defaultAttributedTextForLabelWithText:restaurant.name];
    self.lblDescription.attributedText = [UILabelCustomization defaultAttributedDescriptionForLabelWithText:restaurant.restaurantDescription];
    
    [self.btWishlist setSelected:[self.wishlistHandler checkIfRestaurantIsOnWishlist:restaurant]];
    
    if ([restaurant.url length] != 0) {
        [self.restaurantImg setImageWithURL:[NSURL URLWithString:restaurant.url]];
    }
}

#pragma mark - IBActions
- (IBAction)wishlistAction:(id)sender {
    
    [AnimationHelper bounceButton:sender];
    [self.wishlistHandler addOrRemoveFromWishlistRestaurant:self.restaurant fromSender:sender];
}

@end
