//
//  Dish.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"


@interface Dish : NSObject <JSONObject>


@property (nonatomic, strong) NSNumber      * key;
@property (nonatomic, strong) NSString      * name;
@property (nonatomic, strong) NSString      * dishDescription;
@property (nonatomic, strong) NSString      * url;
@property (nonatomic, strong) NSNumber      * price;


@end
