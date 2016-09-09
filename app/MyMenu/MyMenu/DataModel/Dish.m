//
//  Dish.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "Dish.h"

@implementation Dish


- (id)toJSONObject {
    
    return [NSDictionary dictionary];
}

- (id)initFromJSONObject:(id)jsondict {
    
    self = [super init];
    
    return self;
}

-(BOOL) isValid {
    
    return YES;
}


@end
