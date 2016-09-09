//
//  UILabelCustomization.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabelCustomization : NSObject


+ (NSAttributedString *)defaultLargeAttributedTitleForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultAttributedTitleForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultAttributedTextForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultAttributedDescriptionForLabelWithText:(NSString *)text;


@end
