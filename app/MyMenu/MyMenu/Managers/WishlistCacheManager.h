//
//  WishlistCacheManager.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Restaurant;


@interface WishlistCacheManager : NSObject


+ (WishlistCacheManager *)sharedInstance;

- (void)initWithDelegate:(id)delegate;

- (BOOL)checkIfRestaurantIsOnWishlist:(Restaurant *)product;

- (void)addRestaurantToWishlist:(Restaurant *)product;

- (void)removeRestaurantFromWishlist:(Restaurant *)product;

- (NSArray *)wishlistCacheArray;

- (void)removeAllCache;

@end


@protocol WishlistCacheProtocol <NSObject>

- (void)didFetchWishlistCacheArray:(NSArray *)array;

@end
