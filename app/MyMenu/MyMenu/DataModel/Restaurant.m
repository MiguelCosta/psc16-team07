//
//  Restaurant.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "Restaurant.h"


@implementation Restaurant


- (id)toJSONObject {
    
    NSMutableDictionary * returnObject = [NSMutableDictionary dictionary];

    if (self.address) {
        [returnObject setObject:self.address forKey:@"address"];
    }
    if (self.description) {
        [returnObject setObject:self.restaurantDescription forKey:@"description"];
    }
    if (self.email) {
        [returnObject setObject:self.email forKey:@"email"];
    }
    if (self.key) {
        [returnObject setObject:self.key forKey:@"id"];
    }
    if (self.latitude) {
        [returnObject setObject:self.latitude forKey:@"latitude"];
    }
    if (self.longitude) {
        [returnObject setObject:self.longitude forKey:@"longitude"];
    }
    if (self.phoneNumber) {
        [returnObject setObject:self.phoneNumber forKey:@"phoneNumber"];
    }
    if (self.name) {
        [returnObject setObject:self.name forKey:@"name"];
    }

    return returnObject;
}

- (id)initFromJSONObject:(id)jsondict {
    
    self = [super init];
    
    if (self) {
        
        id address = [jsondict objectForKey:@"address"];
        if (address && [address isKindOfClass:[NSString class]]) {
            self.address = address;
        }
        
        id description = [jsondict objectForKey:@"description"];
        if (description && [description isKindOfClass:[NSString class]]) {
            self.restaurantDescription = description;
        }
        
        id email = [jsondict objectForKey:@"email"];
        if (email && [email isKindOfClass:[NSString class]]) {
            self.email = email;
        }
        
        if ([jsondict objectForKey:@"id"]) {
            self.key = [jsondict objectForKey:@"id"];
        }
        
        id latitude = [jsondict objectForKey:@"latitude"];
        if (latitude) {
            self.latitude = [jsondict objectForKey:@"latitude"];
        }
        
        id longitude = [jsondict objectForKey:@"longitude"];
        if (longitude) {
            self.longitude = [jsondict objectForKey:@"longitude"];
        }
        
        id phoneNumber = [jsondict objectForKey:@"phoneNumber"];
        if (phoneNumber && [phoneNumber isKindOfClass:[NSString class]]) {
            self.phoneNumber = phoneNumber;
        }
        
        id name = [jsondict objectForKey:@"name"];
        if (name && [name isKindOfClass:[NSString class]]) {
            self.name = name;
        }
    }
    
    return self;
}

-(BOOL) isValid {
    
    return YES;
}

@end
