//
//  WishlistViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "WishlistViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UILabelCustomization.h"
#import "RestaurantCollectionViewCell.h"
#import "RestaurantDetailViewController.h"
#import "Restaurant.h"
#import <ChameleonFramework/Chameleon.h>
#import "WishlistHandler.h"


@interface WishlistViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, WishlistHandlerProtocol>


@property (nonatomic, strong) NSMutableArray    * wishlistArray;
@property (nonatomic, strong) WishlistHandler   * wishlistHandler;


@end

@implementation WishlistViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    nibNameOrNil = @"WishlistView";
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.tabBarItem.image = [UIImage imageNamed:@"ic-wishlist"];
    self.tabBarItem.title = @"Wishlist";
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.wishlistHandler = [[WishlistHandler alloc] initWithDelegate:self];
    
    [self.collectionView registerNib:[RestaurantCollectionViewCell registerNib] forCellWithReuseIdentifier:[RestaurantCollectionViewCell reusableIdentifier]];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.emptyDataSetSource = self;
    
    [self setTitle:@"Wishlist"];
    
    [self setStatusBarStyle:UIStatusBarStyleContrast];
    
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.wishlistArray = [[self.wishlistHandler cacheWishlistArray] mutableCopy];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.wishlistArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantCollectionViewCell * restaurantCell = [collectionView dequeueReusableCellWithReuseIdentifier:[RestaurantCollectionViewCell reusableIdentifier] forIndexPath:indexPath];
    
    [restaurantCell loadRestaurant:[self.wishlistArray objectAtIndex:indexPath.row] withWishlistHandler:self.wishlistHandler];
    
    return restaurantCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantDetailViewController * restaurantDetail  = [[RestaurantDetailViewController alloc] initWithRestaurant:[self.wishlistArray objectAtIndex:indexPath.row] fromMap:NO];
    
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

#pragma mark - WishlistActionHandlerProtocol
- (void)didFetchWishlistCacheArray:(NSArray *)wishlistArray {
    
    self.wishlistArray = [NSMutableArray arrayWithArray:[self.wishlistHandler cacheWishlistArray]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView reloadData];
    });
}

- (void)willRemoveRestaurantFromWishlist:(Restaurant *)restaurant {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSUInteger rowToRemove = [self.wishlistArray indexOfObject:restaurant];
        
        [self.wishlistArray removeObject:restaurant];
        
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowToRemove inSection:0]]];
        
        [self.collectionView reloadData];
    });
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
