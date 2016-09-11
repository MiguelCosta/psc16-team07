//
//  WaitingView.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "WaitingView.h"
#import "UIView+Xib.h"
#import <SpinKit/RTSpinKitView.h>
#import <ChameleonFramework/Chameleon.h>

@implementation WaitingView

- (instancetype)init {
    
    self = [WaitingView initWithNibName:@"WaitingView" bundle:nil];
    
    return self;
}

- (void)waitingView {
    
    RTSpinKitView * spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePulse];
    [spinner setColor:[UIColor flatWatermelonColorDark]];
    spinner.spinnerSize = self.containerView.frame.size.width;
    
    [self.containerView addSubview:spinner];
}


@end
