//
//  Restaurant.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"


@interface Restaurant : NSObject <JSONObject>


@property (nonatomic, strong) NSNumber      * key;
@property (nonatomic, strong) NSString      * name;
@property (nonatomic, strong) NSString      * restaurantDescription;
@property (nonatomic, strong) NSString      * url;
@property (nonatomic, strong) NSString      * phoneNumber;
@property (nonatomic, strong) NSArray       * dishes;
@property (nonatomic, strong) NSString      * email;
@property (nonatomic, strong) NSString      * address;
@property (nonatomic, strong) NSNumber      * latitude;
@property (nonatomic, strong) NSNumber      * longitude;
@property (nonatomic, strong) NSString      * type;

@end
