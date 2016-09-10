//
//  SearchManager.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "BaseManager.h"

@interface SearchManager : BaseManager


- (void)searchWithKeyword:(NSString *)keyword;

- (void)dishesForRestaurant:(NSString *)restaurantKey;

- (void)searchWithLatitude:(NSString *)latitude longitude:(NSString *)longitude andRange:(NSString *)range;

- (void)refineSearch:(NSDictionary *)dict withLatitude:(NSString *)latitude longitude:(NSString *)longitude andRange:(NSString *)range;


@end


@protocol SearchManagerDelegate <ManagerDelegate>

@optional
- (void)manager:(BaseManager *)manager didFetchResults:(NSArray *)results forKeyword:(NSString *)keyword;

- (void)manager:(BaseManager *)manager didFetchDishes:(NSArray *)results;

- (void)manager:(BaseManager *)manager didFetchResults:(NSArray *)results;

@end
