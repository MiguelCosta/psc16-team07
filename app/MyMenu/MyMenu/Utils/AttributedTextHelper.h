//
//  AttributedTextHelper.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AttributedTextHelper : NSObject


+ (NSMutableAttributedString *)beautifyWithString:(NSString *)string withFont:(UIFont *)font withColor:(UIColor *)color;

+ (NSMutableAttributedString *)beautifyWithString:(NSString *)string withFont:(UIFont *)font withColor:(UIColor *)color withKerning:(CGFloat)kerning;


@end
