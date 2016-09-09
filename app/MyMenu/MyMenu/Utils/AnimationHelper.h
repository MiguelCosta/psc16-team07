//
//  AnimationHelper.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AnimationHelper : NSObject


+ (void)shakeAnimatonInLabel:(UILabel *)label;

+ (void)scaleAnimationInView:(UIView *)view;

+ (void)hideAnimationForShakeLabel:(UILabel *)label;

+ (void)bounceButton:(UIButton *)button;

+ (void)slideAnimationInView:(UIView *)view withHeighDiferencial:(CGFloat)diferencial;

+ (void)alphaAnimationInView:(UIView *)view toValue:(CGFloat)alphaValue;

+ (void)shadowAnimationInView:(UIView *)view withShadowSizeOffset:(CGSize)sizeOffset shadowOpacity:(CGFloat)opacity;

+ (void)slideCloseAnimationInView:(UIView *)view withDelegate:(id)delegate;

+ (void)scaleAnimationfromValue:(CGSize)fromValue toValue:(CGSize)toValue inView:(UIView *)view withDelegate:(id)delegate;

+ (void)animateBackgroundToColor:(UIColor *)color inView:(UIView *)view;


@end
