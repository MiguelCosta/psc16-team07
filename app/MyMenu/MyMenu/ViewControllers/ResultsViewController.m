//
//  ResultsViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "ResultsViewController.h"
#import "Restaurant.h"
#import "RestaurantCollectionViewCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <ChameleonFramework/Chameleon.h>
#import "RestaurantDetailViewController.h"
#import "UILabelCustomization.h"
#import "WishlistHandler.h"


@interface ResultsViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, DZNEmptyDataSetSource>


@property (nonatomic, strong) NSArray           * resultsArray;
@property (nonatomic, strong) NSString          * keywordSearched;
@property (nonatomic, strong) WishlistHandler   * wishlistHandler;


@end

@implementation ResultsViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:@"ResultsView" bundle:nibBundleOrNil];
    
    return self;
}

- (instancetype)initWithResults:(NSArray *)results andKeywordSearched:(NSString *)keyword {
    
    self = [super init];
    
    if (self) {
        
        self.resultsArray = results;
        self.keywordSearched = keyword;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.wishlistHandler = [[WishlistHandler alloc] initWithDelegate:self];
    
    [self.collectionView registerNib:[RestaurantCollectionViewCell registerNib] forCellWithReuseIdentifier:[RestaurantCollectionViewCell reusableIdentifier]];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.emptyDataSetSource = self;
    
    [self setTitle:self.keywordSearched];
    
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.resultsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantCollectionViewCell * restaurantCell = [collectionView dequeueReusableCellWithReuseIdentifier:[RestaurantCollectionViewCell reusableIdentifier] forIndexPath:indexPath];
    
    [restaurantCell loadRestaurant:[self.resultsArray objectAtIndex:indexPath.row] withWishlistHandler:self.wishlistHandler];
    
    [restaurantCell.restaurantImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic-test%ld", (long)indexPath.row]]];
    
    return restaurantCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantDetailViewController * restaurantDetail  = [[RestaurantDetailViewController alloc] initWithRestaurant:[self.resultsArray objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:restaurantDetail animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
}

#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"ic-wishlist-degraded"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UILabelCustomization defaultAttributedTitleForLabelWithText:@"Nothing here, yet!"];
}

- (NSAttributedString *)defaultAttributedDescriptionForLabelWithText:(UIScrollView *)scrollView {
    
    return [UILabelCustomization defaultAttributedDescriptionForLabelWithText:@"Save your favourite yummi stuff for later..."];
    
}

#pragma mark <RMPZoomTransitionAnimating>
- (UIImageView *)transitionSourceImageView {
    
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    RestaurantCollectionViewCell *cell = (RestaurantCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.restaurantImg.image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = NO;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [cell.restaurantImg convertRect:cell.restaurantImg.frame toView:self.collectionView.superview];
    
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor {
    
    return [UIColor clearColor];
}

- (CGRect)transitionDestinationImageViewFrame {
    
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    RestaurantCollectionViewCell *cell = (RestaurantCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    CGRect cellFrameInSuperview = [cell.restaurantImg convertRect:cell.restaurantImg.frame toView:self.collectionView.superview];
    return cellFrameInSuperview;
}

@end
