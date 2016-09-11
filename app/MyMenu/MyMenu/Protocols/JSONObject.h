//
//  JSONObject.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol JSONObject <NSObject>


- (id)toJSONObject;

- (id)initFromJSONObject:(id) jsondict;

-(BOOL) isValid;

@end
