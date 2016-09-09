//
//  TabBarViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "TabBarViewController.h"
#import "SearchViewController.h"
#import "MapViewController.h"
#import "WishlistViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "RestaurantDetailViewController.h"
#import "RMPZoomTransitionAnimator.h"


@interface TabBarViewController () <UINavigationControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SearchViewController * viewController = [[SearchViewController alloc] init];
    
    UINavigationController * searchNavController = [[UINavigationController alloc] initWithRootViewController:viewController];
    searchNavController.delegate = self;
    
    searchNavController.navigationBar.translucent = NO;
    [searchNavController.navigationBar setBarTintColor:[UIColor flatWatermelonColorDark]];
    searchNavController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    
    MapViewController * mapView = [[MapViewController alloc] init];
    
    WishlistViewController * wishlistView = [[WishlistViewController alloc] init];
    
    UINavigationController * wishlistNavController = [[UINavigationController alloc] initWithRootViewController:wishlistView];
    wishlistNavController.navigationBar.translucent = NO;
    [wishlistNavController.navigationBar setBarTintColor:[UIColor flatWatermelonColorDark]];
    wishlistNavController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    
    [self setViewControllers:[NSArray arrayWithObjects:searchNavController, mapView, wishlistNavController, nil]];
    
    [self setSelectedViewController:mapView];
    
    self.tabBar.translucent = NO;
    
    self.tabBar.tintColor = [UIColor flatWatermelonColorDark];
}

#pragma mark - <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop || [fromVC isKindOfClass:[RestaurantDetailViewController class]]) {
        return nil;
    }
    
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)fromVC;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)toVC;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = (operation == UINavigationControllerOperationPush);
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

@end
