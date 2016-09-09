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


- (instancetype)initWithResults:(NSArray *)results andKeywordSearched:(NSString *)keyword;


@end
