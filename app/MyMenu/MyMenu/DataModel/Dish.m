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
    
    if (self) {
    
        self.name = [jsondict objectForKey:@"name"];
        self.price = [jsondict objectForKey:@"price"];
        self.dishDescription = [jsondict objectForKey:@"description"];
        self.url = [jsondict objectForKey:@"photo"];
        self.key = [jsondict objectForKey:@"id"];
    }
    
    return self;
}

-(BOOL) isValid {
    
    return YES;
}


@end
