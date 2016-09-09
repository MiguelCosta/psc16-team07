//
//  AbstractViewController.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractViewController : UIViewController


- (void)alertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle message:(NSString *)message andOtherButtonTitle:(NSString *)otherButtonTitle;

- (void)presentWaitingView;

- (void)dismissWaitingView;

@end
