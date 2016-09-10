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

+ (NSAttributedString *)defaultWhiteAttributedTitleForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultGrayAttributedTitleForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultAttributedRedTitleForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultAttributedTextForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultAttributedRedTextForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultBoldAttributedTextForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultAttributedDescriptionForLabelWithText:(NSString *)text;

+ (NSAttributedString *)defaultBlackAttributedDescriptionForLabelWithText:(NSString *)text;

@end
