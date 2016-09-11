//
//  CollectionViewCellProtocol.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CollectionViewCellProtocol <NSObject>

+ (UINib *)registerNib;

+ (NSString *)reusableIdentifier;

@end
