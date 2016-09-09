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
#import "RestaurantFooterCollectionReusableView.h"
#import "DishCollectionViewCell.h"
#import <ChameleonFramework/Chameleon.h>
#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout.h>
#import "AnimationHelper.h"


@interface RestaurantDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) Restaurant        * restaurant;
@property (nonatomic, weak) RestaurantHeaderCollectionReusableView * headerView;

@end

@implementation RestaurantDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:@"RestaurantDetailView" bundle:nibBundleOrNil];
    
    return self;
}

- (instancetype)initWithRestaurant:(Restaurant *)restaurant {
    
    self = [super init];
    
    if (self) {
        
        self.restaurant = restaurant;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerNib:[RestaurantHeaderCollectionReusableView registerNib] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:[RestaurantHeaderCollectionReusableView reusableIdentifier]];
    
    [self.collectionView registerNib:[RestaurantFooterCollectionReusableView registerNib] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[RestaurantFooterCollectionReusableView reusableIdentifier]];
    
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DishCollectionViewCell * dischCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DishCollectionViewCell reusableIdentifier] forIndexPath:indexPath];
    
    return dischCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == CSStickyHeaderParallaxHeader) {
        
        RestaurantHeaderCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[RestaurantHeaderCollectionReusableView reusableIdentifier] forIndexPath:indexPath];
        self.headerView = header;
        
        return header;
    }
    
    RestaurantFooterCollectionReusableView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[RestaurantFooterCollectionReusableView reusableIdentifier] forIndexPath:indexPath];
    
    [footer updateRestaurantPosition:self.restaurant];
    
    return footer;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 150);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
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
   // self.headerView.containerView.alpha = 0;
   // [self.headerView.containerView setHidden:NO];
   // [AnimationHelper alphaAnimationInView:self.headerView.containerView toValue:1];
}

@end
