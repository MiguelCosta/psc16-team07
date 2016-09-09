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

@end


@protocol SearchManagerDelegate <ManagerDelegate>

- (void)manager:(BaseManager *)manager didFetchResults:(NSArray *)results forKeyword:(NSString *)keyword;

@end
