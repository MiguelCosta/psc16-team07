//
//  AnimationHelper.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AnimationHelper.h"
#import <pop/POP.h>

@implementation AnimationHelper

+ (void)shakeAnimatonInLabel:(UILabel *)label {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        label.layer.opacity = 1.0;
    });
    
    POPSpringAnimation * layerScaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness = 18;
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    
    [label.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
}

+ (void)scaleAnimationInView:(UIView *)view {
    
    POPSpringAnimation * scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 18;
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.3f, 1.3f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

+ (void)hideAnimationForShakeLabel:(UILabel *)label {
    
    POPBasicAnimation * layerScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    
    POPBasicAnimation * layerOpacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    layerOpacityAnimation.toValue = @(0);
    
    [label.layer pop_addAnimation:layerOpacityAnimation forKey:@"layerOpacityAnimation"];
    [label.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
}

+ (void)bounceButton:(UIButton *)button {
    
    POPSpringAnimation * layerScaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness = 20;
    layerScaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.2f, 1.2f)];
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [layerScaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        button.userInteractionEnabled = YES;
    }];
    
    [button.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
}

+ (void)slideAnimationInView:(UIView *)view withHeighDiferencial:(CGFloat)diferencial {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        view.layer.opacity = 1;
    });
    
    POPSpringAnimation * positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
    positionAnimation.fromValue = @(view.frame.size.height-diferencial);
    positionAnimation.toValue = @(0);
    positionAnimation.springBounciness = 7;
    
    [view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

+ (void)slideCloseAnimationInView:(UIView *)view withDelegate:(id)delegate {
    
    POPSpringAnimation * positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
    positionAnimation.toValue = @(view.frame.size.height);
    positionAnimation.fromValue = @(0);
    positionAnimation.springBounciness = 0;
    
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        if (finished) {
           
        }
    }];
    
    [view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

+ (void)scaleAnimationfromValue:(CGSize)fromValue toValue:(CGSize)toValue inView:(UIView *)view withDelegate:(id)delegate {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        view.layer.opacity = 1;
    });
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    positionAnimation.fromValue = [NSValue valueWithCGSize:fromValue];
    positionAnimation.toValue = [NSValue valueWithCGSize:toValue];
    positionAnimation.springBounciness = 2;
    
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
    
    }];
    
    [view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

+ (void)alphaAnimationInView:(UIView *)view toValue:(CGFloat)alphaValue {
    
    POPSpringAnimation * positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
    positionAnimation.toValue = @(alphaValue);
    
    [view pop_addAnimation:positionAnimation forKey:@"alphaAnimation"];
}

+ (void)shadowAnimationInView:(UIView *)view withShadowSizeOffset:(CGSize)sizeOffset shadowOpacity:(CGFloat)opacity {
    
    POPSpringAnimation * shadowOffsetAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowOffset];
    shadowOffsetAnimation.toValue = [NSValue valueWithCGSize:sizeOffset];
    
    
    POPSpringAnimation * positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowColor];
    positionAnimation.toValue = (__bridge id)([[UIColor blackColor] CGColor]);
    
    
    POPSpringAnimation * shadowOpacityAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowOpacity];
    shadowOpacityAnimation.toValue = @(opacity);
    
    [view.layer pop_addAnimation:shadowOffsetAnimation forKey:@"shadowOffsetAnimation"];
    [view.layer pop_addAnimation:shadowOpacityAnimation forKey:@"shadowOpacityAnimation"];
    [view.layer pop_addAnimation:positionAnimation forKey:@"shadowColorAnimation"];
}

+ (void)animateBackgroundToColor:(UIColor *)color inView:(UIView *)view {
    
    POPSpringAnimation * backgroundColorAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    backgroundColorAnimation.toValue = color;
    
    [view.layer pop_addAnimation:backgroundColorAnimation forKey:@"backgroundColorAnimation"];
}

@end
