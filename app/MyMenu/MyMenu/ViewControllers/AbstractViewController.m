//
//  AbstractViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "WaitingView.h"


@interface AbstractViewController ()


@property (nonatomic, strong) WaitingView        * waitingView;

@end

@implementation AbstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([[self.navigationController viewControllers] count] != 1) {
        [self backButton];
    }
}

- (void)removeNavigationBarShadow {
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)addNavigationBarShadow {
    
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor flatWatermelonColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)backButton {
    
    UIImage * buttonImage = [UIImage imageNamed:@"ic-back"];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width+44, 44);
    [button addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = customBarItem;
}

#pragma mark - WaitingView
- (void)presentWaitingView {
    
    if (!self.waitingView) {
        self.waitingView = [[WaitingView alloc] init];
        self.waitingView.frame = [UIScreen mainScreen].bounds;
        
        [self.waitingView layoutIfNeeded];
    }
    
    [self.waitingView waitingView];
    
    [self.view addSubview:self.waitingView];
    __weak AbstractViewController * weakSelf=self;
    
    [weakSelf.waitingView setAlpha:0.0];
    
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.waitingView setAlpha:1.0];
    }];
}

- (void)dismissWaitingView {
    
    __weak AbstractViewController * weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.waitingView setAlpha:1.0];
        } completion:^(BOOL finished) {
            if (finished) {
                [weakSelf.waitingView removeFromSuperview];
            }
        }];
    });
}

#pragma mark - UIAlertView Methods
- (void)alertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle message:(NSString *)message andOtherButtonTitle:(NSString *)otherButtonTitle {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        UIAlertView * alertView =[[UIAlertView alloc] initWithTitle:NSLocalizedString(title,"") message:NSLocalizedString(message, @"") delegate:self cancelButtonTitle:NSLocalizedString(cancelButtonTitle,"")  otherButtonTitles: nil];
        
        if (otherButtonTitle) {
            [alertView addButtonWithTitle:NSLocalizedString(otherButtonTitle, "")];
        }
        
        [alertView show];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark - IBActions
- (void)popView {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
