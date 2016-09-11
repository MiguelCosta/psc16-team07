//
//  WishlistHandler.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol WishlistHandlerProtocol;

@class Restaurant;

@interface WishlistHandler : NSObject


@property (nonatomic, weak) id <WishlistHandlerProtocol>    delegate;


- (instancetype)initWithDelegate:(id)delegate;

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (BOOL)checkIfRestaurantIsOnWishlist:(Restaurant *)restaurant;

- (void)addOrRemoveFromWishlistRestaurant:(Restaurant *)restaurant fromSender:(UIButton *)sender;

- (NSArray *)cacheWishlistArray;

@end

@protocol WishlistHandlerProtocol <NSObject>

@optional
- (void)willRemoveRestaurantFromWishlist:(Restaurant *)restaurant;

- (void)requestToRemoveRestaurantFromWishlistFailed;

- (void)removeRestaurantFromWishlist:(Restaurant *)restaurant;

- (void)restaurantRemove:(Restaurant *)restaurant;

- (void)addRestaurant:(Restaurant *)restaurant;

- (void)didFetchWishlistCacheArray:(NSArray *)wishlistArray;

@end
