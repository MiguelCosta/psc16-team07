//
//  RestaurantDetailViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "Restaurant.h"
#import "RestaurantHeaderCollectionReusableView.h"
#import "DishCollectionViewCell.h"
#import <ChameleonFramework/Chameleon.h>
#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout.h>
#import "AnimationHelper.h"
#import "DishHeaderCollectionReusableView.h"
#import "SearchManager.h"
#import "MapDetailViewController.h"


@interface RestaurantDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SearchManagerDelegate>


@property (nonatomic, strong) Restaurant                           * restaurant;
@property (nonatomic, strong) NSArray                              * dishArray;
@property (nonatomic, weak) RestaurantHeaderCollectionReusableView * headerView;
@property (nonatomic, assign) BOOL                                   fromMap;

@end

@implementation RestaurantDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:@"RestaurantDetailView" bundle:nibBundleOrNil];
    
    return self;
}

- (instancetype)initWithRestaurant:(Restaurant *)restaurant fromMap:(BOOL)fromMap {
    
    self = [super init];
    
    if (self) {
        
        self.restaurant = restaurant;
        self.fromMap = fromMap;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navigationBarRightButtonWithImage:[UIImage imageNamed:@"ic-map-nav"] selectedImage:nil action:@selector(openMap) andTarget:self];
    
    SearchManager * manager = [[SearchManager alloc] initWithDelegate:self];
    [manager dishesForRestaurant:[self.restaurant.key stringValue]];
    
    [self.collectionView registerNib:[RestaurantHeaderCollectionReusableView registerNib] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:[RestaurantHeaderCollectionReusableView reusableIdentifier]];
    
    [self.collectionView registerNib:[DishHeaderCollectionReusableView registerNib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[DishHeaderCollectionReusableView reusableIdentifier]];
    
    [self.collectionView registerNib:[DishCollectionViewCell registerNib] forCellWithReuseIdentifier:[DishCollectionViewCell reusableIdentifier]];
    
    CSStickyHeaderFlowLayout * layout = [[CSStickyHeaderFlowLayout alloc] init];
    layout.parallaxHeaderReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, layout.itemSize.height);
    layout.parallaxHeaderMinimumReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    layout.parallaxHeaderAlwaysOnTop = YES;
    layout.disableStickyHeaders = YES;
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
    
    [self setTitle:self.restaurant.name];
}

- (void)openMap {
    
    MapDetailViewController * mapDetail = [[MapDetailViewController alloc] initWithLatitude:self.restaurant.latitude andLongitude:self.restaurant.longitude];
    
    [self.navigationController pushViewController:mapDetail animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSArray * visibleHeaders =  [self.collectionView visibleSupplementaryViewsOfKind:UICollectionElementKindSectionHeader];
    
    if ([visibleHeaders count] == 0 && scrollView.contentOffset.y>300) {
        
        [self setTitle:@"Dishes"];
    }else {
        [self setTitle:self.restaurant.name];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dishArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DishCollectionViewCell * dischCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DishCollectionViewCell reusableIdentifier] forIndexPath:indexPath];
    
    [dischCell loadDish:[self.dishArray objectAtIndex:indexPath.row]];
    
    return dischCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == CSStickyHeaderParallaxHeader) {
        
        RestaurantHeaderCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[RestaurantHeaderCollectionReusableView reusableIdentifier] forIndexPath:indexPath];
        self.headerView = header;
        
        [header loadRestaurant:self.restaurant];
        
        if (self.fromMap) {
            [header.img setHidden:NO];
            [header.containerView setHidden:NO];
        }
        
        return header;
    }else  {
        
        DishHeaderCollectionReusableView * dishHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[DishHeaderCollectionReusableView reusableIdentifier] forIndexPath:indexPath];
        
        return dishHeader;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DishCollectionViewCell * dishCell = (DishCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (dishCell.contraint.constant == 0) {
        [AnimationHelper slideAnimationInView:dishCell.contraint withHeighDiferencial:(collectionView.frame.size.width/2)-7-40];
    }else {
        [AnimationHelper slideAnimationInView:dishCell.contraint withHeighDiferencial:0];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((collectionView.frame.size.width/2)-7, (collectionView.frame.size.width/2)-7);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if ([self.dishArray count] != 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
    }
    
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

#pragma mark - SearchManagerDelegate
- (void)manager:(BaseManager *)manager didFetchDishes:(NSArray *)results {
    
    self.dishArray = [NSArray arrayWithArray:results];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView reloadData];
    });
}

#pragma mark - <RMPZoomTransitionAnimating>
- (UIImageView *)transitionSourceImageView {
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:self.headerView.img.image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = self.headerView.img.frame;
    
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor {
    
    return [UIColor flatWhiteColor];
}

- (CGRect)transitionDestinationImageViewFrame {
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGRect frame = self.headerView.img.frame;
    frame.size.width = width;
    return CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 250);
}

- (void)zoomTransitionAnimator:(RMPZoomTransitionAnimator *)animator
         didCompleteTransition:(BOOL)didComplete
      animatingSourceImageView:(UIImageView *)imageView{
    
    [self.headerView.img setHidden:NO];
    self.headerView.containerView.alpha = 0;
    [self.headerView.containerView setHidden:NO];
    [AnimationHelper alphaAnimationInView:self.headerView.containerView toValue:1];
}

@end
