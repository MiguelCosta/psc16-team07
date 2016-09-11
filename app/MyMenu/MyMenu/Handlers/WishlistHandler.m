//
//  WishlistHandler.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "WishlistHandler.h"
#import "WishlistCacheManager.h"
#import "Restaurant.h"

@interface WishlistHandler () <WishlistCacheProtocol>

@property (nonatomic, strong) Restaurant                 * currentRestaurant;
@property (nonatomic, weak) UIButton                     * bt;
@property (nonatomic, weak) UIViewController             * viewController;


@end


@implementation WishlistHandler


- (instancetype)initWithDelegate:(id)delegate {
    
    self = [super init];
    
    if (self) {
        self.delegate = delegate;
        [[WishlistCacheManager sharedInstance] initWithDelegate:self];
    }
    
    return self;
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    
    self = [self initWithDelegate:viewController];
    
    if (self) {
        
        self.viewController = viewController;
    }
    
    return self;
}

- (BOOL)checkIfRestaurantIsOnWishlist:(Restaurant *)restaurant {
    
    return [[WishlistCacheManager sharedInstance] checkIfRestaurantIsOnWishlist:restaurant];
}

-(void)addOrRemoveFromWishlistRestaurant:(Restaurant *)restaurant fromSender:(UIButton *)sender {
    
    self.currentRestaurant = restaurant;
    self.bt = sender;
    
    [sender setSelected:!sender.isSelected];
    
    if ([[WishlistCacheManager sharedInstance] checkIfRestaurantIsOnWishlist:self.currentRestaurant]) {
        [[WishlistCacheManager sharedInstance] removeRestaurantFromWishlist:self.currentRestaurant];
        
        if ([self.delegate respondsToSelector:@selector(willRemoveRestaurantFromWishlist:)]) {
            [self.delegate willRemoveRestaurantFromWishlist:restaurant];
        }
    } else {
        [[WishlistCacheManager sharedInstance] addRestaurantToWishlist:self.currentRestaurant];
    }
}

- (NSArray *)cacheWishlistArray {
    
    return [[WishlistCacheManager sharedInstance] wishlistCacheArray];
}

#pragma mark - WishlistCacheProtocol
- (void)didFetchWishlistCacheArray:(NSArray *)array {
    
    if ([self.delegate respondsToSelector:@selector(didFetchWishlistCacheArray:)]) {
        [self.delegate didFetchWishlistCacheArray:array];
    }
    
}

@end
