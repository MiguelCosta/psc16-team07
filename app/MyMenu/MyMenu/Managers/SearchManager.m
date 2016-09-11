//
//  SearchManager.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "SearchManager.h"
#import "HTTPConstants.h"
#import "Restaurant.h"
#import "Dish.h"


@implementation SearchManager


- (void)searchWithKeyword:(NSString *)keyword {
    
    [self getData:[NSString stringWithFormat:HTTPSearch, [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] successBlock:^(id object) {
        
        NSArray * resultsRestaurants = [self responseArrayFromJSONObject:[object valueForKey:@"restaurants"] objectsWithClass:[Restaurant class]];
        NSArray * resultsDishes = [self responseArrayFromJSONObject:[object valueForKey:@"dishes"] objectsWithClass:[Dish class]];
        
        if ([self.delegate respondsToSelector:@selector(manager:didFetchResults:forKeyword:)]) {
            [self.delegate manager:self didFetchResults:[NSArray arrayWithObjects:resultsRestaurants, resultsDishes, nil] forKeyword:keyword];
        }
        
    } andFailureBlock:nil];
}

- (void)dishesForRestaurant:(NSString *)restaurantKey {
    
    [self getData:[NSString stringWithFormat:HTTPDish, restaurantKey] successBlock:^(id object) {
        
        NSArray * results = [self responseArrayFromJSONObject:object objectsWithClass:[Dish class]];
        
        if ([self.delegate respondsToSelector:@selector(manager:didFetchDishes:)]) {
            [self.delegate manager:self didFetchDishes:results];
        }
    } andFailureBlock:nil];
}

- (void)searchWithLatitude:(NSString *)latitude longitude:(NSString *)longitude andRange:(NSString *)range {
    
    [self addHeadersWithLatitude:latitude longitude:longitude andRange:range];
    
    [self getData:HTTPMapSearch successBlock:^(id object) {
        
        NSArray * results = [self responseArrayFromJSONObject:[object valueForKey:@"restaurants"] objectsWithClass:[Restaurant class]];

        if ([self.delegate respondsToSelector:@selector(manager:didFetchResults:)]) {
            [self.delegate manager:self didFetchResults:results];
        }
    } andFailureBlock:nil];
}

- (void)refineSearch:(NSDictionary *)dict withLatitude:(NSString *)latitude longitude:(NSString *)longitude andRange:(NSString *)range {
    
    [self addHeadersWithLatitude:latitude longitude:longitude andRange:range];

    [self postDataToEndpoint:HTTPMapSearch withData:dict successBlock:^(id object) {
        
        NSArray * resultsRestaurants = [self responseArrayFromJSONObject:[object valueForKey:@"restaurants"] objectsWithClass:[Restaurant class]];
        NSArray * resultsDishes = [self responseArrayFromJSONObject:[object valueForKey:@"dishes"] objectsWithClass:[Dish class]];
        
        if ([self.delegate respondsToSelector:@selector(manager:didFetchResults:forKeyword:)]) {
            [self.delegate manager:self didFetchResults:[NSArray arrayWithObjects:resultsRestaurants, resultsDishes, nil] forKeyword:nil];
        }

    } andFailureBlock:nil];
}

@end
