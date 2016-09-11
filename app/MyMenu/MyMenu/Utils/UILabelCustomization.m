//
//  UILabelCustomization.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "UILabelCustomization.h"
#import "AttributedTextHelper.h"
#import <ChameleonFramework/Chameleon.h>


@implementation UILabelCustomization


+ (NSAttributedString *)defaultLargeAttributedTitleForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont boldSystemFontOfSize:22] withColor:[UIColor flatBlackColor] withKerning:1.0];
}

+ (NSAttributedString *)defaultAttributedTitleForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont systemFontOfSize:14] withColor:[UIColor flatBlackColor] withKerning:1.0];
}

+ (NSAttributedString *)defaultWhiteAttributedTitleForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] withKerning:1.0];
}

+ (NSAttributedString *)defaultGrayAttributedTitleForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont systemFontOfSize:14] withColor:[UIColor flatWhiteColorDark] withKerning:1.0];
}


+ (NSAttributedString *)defaultAttributedRedTitleForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont boldSystemFontOfSize:15] withColor:[UIColor flatWatermelonColorDark] withKerning:1.0];
}

+ (NSAttributedString *)defaultAttributedTextForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont systemFontOfSize:12] withColor:[UIColor flatBlackColor] withKerning:1.0];
}

+ (NSAttributedString *)defaultAttributedRedTextForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont systemFontOfSize:12] withColor:[UIColor flatWatermelonColorDark] withKerning:1.0];
}

+ (NSAttributedString *)defaultBoldAttributedTextForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont boldSystemFontOfSize:12] withColor:[UIColor flatBlackColor] withKerning:1.0];
    
}

+ (NSAttributedString *)defaultAttributedDescriptionForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont systemFontOfSize:10] withColor:[UIColor flatWhiteColorDark] withKerning:1.0];
}

+ (NSAttributedString *)defaultBlackAttributedDescriptionForLabelWithText:(NSString *)text {
    
    return [AttributedTextHelper beautifyWithString:text withFont:[UIFont systemFontOfSize:10] withColor:[UIColor flatBlackColor] withKerning:1.0];
}


@end
