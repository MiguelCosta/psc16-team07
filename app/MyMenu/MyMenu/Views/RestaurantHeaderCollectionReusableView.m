//
//  RestaurantHeaderCollectionReusableView.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "RestaurantHeaderCollectionReusableView.h"
#import "UILabelCustomization.h"
#import "Restaurant.h"
#import "UIImageView+AFNetworking.h"


@implementation RestaurantHeaderCollectionReusableView


#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"RestaurantHeaderReusableView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"Header";
}

- (void)loadRestaurant:(Restaurant *)restaurant {
    
    self.lblPhone.attributedText = [UILabelCustomization defaultAttributedRedTextForLabelWithText:restaurant.phoneNumber];
    
    self.lblCategory.attributedText = [UILabelCustomization defaultAttributedTextForLabelWithText:restaurant.type];
    
    [self.img setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mymenuapi.azurewebsites.net/api/Restaurants/%@/Photo", [restaurant.key stringValue]]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
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

#pragma mark - IBActions
- (IBAction)callAction:(id)sender {
    
    NSString * phone = [NSString stringWithFormat:@"telprompt:%@", [self.lblPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    NSURL * phoneUrl = [NSURL URLWithString:phone];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
}


@end
