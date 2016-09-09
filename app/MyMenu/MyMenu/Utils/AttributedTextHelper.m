//
//  AttributedTextHelper.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AttributedTextHelper.h"


@implementation AttributedTextHelper


+ (NSMutableAttributedString *)beautifyWithString:(NSString *)string withFont:(UIFont *)font withColor:(UIColor *)color {
    
    NSString* labelStr = string;
    
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] init];
    
    if (![labelStr isKindOfClass:[NSNull class]]) {
        NSUInteger strLength = [labelStr length];
        
        if (strLength > 0) {
            attStr = [[NSMutableAttributedString alloc] initWithString:labelStr];
            
            [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, strLength)];
            [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, strLength)];
            [attStr addAttribute:NSLigatureAttributeName value:[NSNumber numberWithFloat:0] range:NSMakeRange(0, strLength)];
        }
    }
    
    return attStr;
}

+ (NSMutableAttributedString *)beautifyWithString:(NSString *)string withFont:(UIFont *)font withColor:(UIColor *)color withKerning:(CGFloat)kerning {
    
    NSMutableAttributedString * attStr = [self beautifyWithString:string withFont:font withColor:color];
    NSUInteger strLength = [attStr length];
    [attStr addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:kerning] range:NSMakeRange(0, strLength)];
    
    return attStr;
}

@end
