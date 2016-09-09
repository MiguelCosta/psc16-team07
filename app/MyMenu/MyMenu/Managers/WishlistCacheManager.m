//
//  WishlistCacheManager.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "WishlistCacheManager.h"
#import "PINCache.h"
#import "Restaurant.h"


@interface WishlistCacheManager ()

@property (nonatomic, strong) PINDiskCache         * diskCache;
@property (nonatomic, strong) NSMutableArray       * wishlistArray;
@property (nonatomic, weak) id                       delegate;

@end


@implementation WishlistCacheManager

+ (WishlistCacheManager *)sharedInstance {
    
    static WishlistCacheManager      * sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        
        sharedInstance = [[self alloc] init];
        sharedInstance.diskCache = [[PINDiskCache alloc] initWithName:@"WishlistCache" rootPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Wishlist"]];
        
        [sharedInstance loadWishlist];
    });
    
    return sharedInstance;
}

- (void)initWithDelegate:(id)delegate {
    
    self.delegate = delegate;
}

- (void)loadWishlist {
    
    self.wishlistArray = [NSMutableArray array];
    [self.diskCache enumerateObjectsWithBlock:^(PINDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL) {
        
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:[fileURL path]];
        id parsedObject = [[Restaurant alloc] initFromJSONObject:object];
        if (parsedObject) {
            [self.wishlistArray insertObject:parsedObject atIndex:0];
        }
    } completionBlock:^(PINDiskCache * _Nonnull cache) {
        
        if ([self.delegate respondsToSelector:@selector(didFetchWishlistCacheArray:)]) {
            [self.delegate didFetchWishlistCacheArray:self.wishlistArray];
        }
    }];
}

- (BOOL)checkIfRestaurantIsOnWishlist:(Restaurant *)restaurant {
    
    for (Restaurant * wishlistRestaurant in self.wishlistArray) {
        if ([[wishlistRestaurant.key stringValue] isEqualToString:[restaurant.key stringValue]]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)addRestaurantToWishlist:(Restaurant *)restaurant {
    
    if (restaurant == nil) {
        return;
    }
    
    [self.diskCache setObject:[restaurant toJSONObject] forKey:[restaurant.key stringValue] block:NULL];
    if (![self.wishlistArray containsObject:restaurant]) {
        [self.wishlistArray insertObject:restaurant atIndex:0];
    }
}

- (void)removeRestaurantFromWishlist:(Restaurant *)restaurant {
    
    if (restaurant == nil) {
        return;
    }
    
    [self.diskCache removeObjectForKey:[restaurant.key stringValue]];
    [self.wishlistArray removeObject:restaurant];
}

- (void)removeAllCache {
    
    [self.diskCache removeAllObjects];
    [self.wishlistArray removeAllObjects];
}

- (NSArray *)wishlistCacheArray {
    
    if (!self.wishlistArray) {
        [self loadWishlist];
    }
    
    return self.wishlistArray;
}

@end
