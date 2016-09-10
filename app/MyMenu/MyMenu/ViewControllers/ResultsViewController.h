//
//  ResultsViewController.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"
#import "RMPZoomTransitionAnimator.h"


@interface ResultsViewController : AbstractViewController <RMPZoomTransitionAnimating>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btRestaurants;
@property (weak, nonatomic) IBOutlet UIButton *btDishes;
@property (weak, nonatomic) IBOutlet UIView *tabView;


- (instancetype)initWithResults:(NSArray *)results andKeywordSearched:(NSString *)keyword;

- (void)refineWithResults:(NSArray *)results;

@end
