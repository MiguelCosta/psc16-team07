//
//  UIView+Xib.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "UIView+Xib.h"

@implementation UIView (Xib)


+ (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    UIViewController * viewController=[[UIViewController alloc] initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [viewController loadView];
    return viewController.view;
}


@end
