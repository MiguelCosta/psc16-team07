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


@implementation SearchManager


- (void)searchWithKeyword:(NSString *)keyword {
    
    [self getData:[NSString stringWithFormat:HTTPSearch, keyword] successBlock:^(id object) {
        
        NSArray * results = [self responseArrayFromJSONObject:object objectsWithClass:[Restaurant class]];
        
        if ([self.delegate respondsToSelector:@selector(manager:didFetchResults:forKeyword:)]) {
            [self.delegate manager:self didFetchResults:results forKeyword:keyword];
        }
        
    } andFailureBlock:nil];
}

@end
