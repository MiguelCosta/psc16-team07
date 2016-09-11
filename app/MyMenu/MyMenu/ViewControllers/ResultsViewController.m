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
#import "DishCollectionViewCell.h"
#import "AnimationHelper.h"
#import "RefineViewController.h"


@interface ResultsViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, DZNEmptyDataSetSource>


@property (nonatomic, strong) NSArray           * resultsArray;
@property (nonatomic, strong) NSString          * keywordSearched;
@property (nonatomic, strong) WishlistHandler   * wishlistHandler;
@property (nonatomic, strong) NSArray           * restaurantArray;
@property (nonatomic, strong) NSArray           * dishesArray;
@property (nonatomic, strong) NSArray           * dataSourceArray;


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
    
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
    
    [self navigationBarRightButtonWithImage:[UIImage imageNamed:@"ic-refine"] selectedImage:nil action:@selector(openRefine) andTarget:self];
    
    self.wishlistHandler = [[WishlistHandler alloc] initWithDelegate:self];
    
    [self.collectionView registerNib:[RestaurantCollectionViewCell registerNib] forCellWithReuseIdentifier:[RestaurantCollectionViewCell reusableIdentifier]];
    
    [self.collectionView registerNib:[DishCollectionViewCell registerNib] forCellWithReuseIdentifier:[DishCollectionViewCell reusableIdentifier]];
    
    if (self.resultsArray.count >=1) {
        self.restaurantArray = [NSArray arrayWithArray:[self.resultsArray objectAtIndex:0]];
        
        if ([self.resultsArray count] == 2) {
            self.dishesArray = [NSArray arrayWithArray:[self.resultsArray objectAtIndex:1]];
        }
    }
    
    self.dataSourceArray = [NSArray arrayWithArray:self.restaurantArray];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.emptyDataSetSource = self;
    
    [self setTitle:self.keywordSearched];
    
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
    
    [self.btRestaurants setAttributedTitle:[UILabelCustomization defaultAttributedTitleForLabelWithText:@"Restaurants"] forState:UIControlStateNormal];
    
    [self.btRestaurants setAttributedTitle:[UILabelCustomization defaultAttributedRedTitleForLabelWithText:@"Restaurants"] forState:UIControlStateSelected];
    
    [self.btDishes setAttributedTitle:[UILabelCustomization defaultAttributedTitleForLabelWithText:@"Dishes"] forState:UIControlStateNormal];
    
    [self.btDishes setAttributedTitle:[UILabelCustomization defaultAttributedRedTitleForLabelWithText:@"Dishes"] forState:UIControlStateSelected];
    
    [self.btRestaurants setSelected:YES];
}

#pragma mark - IBActions
- (IBAction)restaurantsAction:(id)sender {
    
    [sender setSelected:YES];
    [self.btDishes setSelected:NO];
    
    self.dataSourceArray = [NSArray arrayWithArray:self.restaurantArray];
    
    [self.collectionView reloadData];
}

- (IBAction)dishesAction:(id)sender {
    
    [sender setSelected:YES];
    [self.btRestaurants setSelected:NO];
    
    self.dataSourceArray = [NSArray arrayWithArray:self.dishesArray];
    
    [self.collectionView reloadData];
}

- (void)openRefine {
    
    RefineViewController * refineView = [[RefineViewController alloc] init];
    
    [self.navigationController pushViewController:refineView animated:YES];
}

- (void)refineWithResults:(NSArray *)results {
    
    self.resultsArray = [NSArray arrayWithArray:results];
    
    if (self.resultsArray.count >=1) {
        self.restaurantArray = [NSArray arrayWithArray:[self.resultsArray objectAtIndex:0]];
        
        if ([self.resultsArray count] == 2) {
            self.dishesArray = [NSArray arrayWithArray:[self.resultsArray objectAtIndex:1]];
        }
    }
    
    if ([self.btDishes isSelected]) {
        self.dataSourceArray = [NSArray arrayWithArray:self.dishesArray];
    }else {
        self.dataSourceArray = [NSArray arrayWithArray:self.restaurantArray];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataSourceArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.btRestaurants isSelected]) {
        RestaurantCollectionViewCell * restaurantCell = [collectionView dequeueReusableCellWithReuseIdentifier:[RestaurantCollectionViewCell reusableIdentifier] forIndexPath:indexPath];
        
        [restaurantCell loadRestaurant:[self.dataSourceArray objectAtIndex:indexPath.row] withWishlistHandler:self.wishlistHandler];
        
        return restaurantCell;
    }
    
    DishCollectionViewCell * dischCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DishCollectionViewCell reusableIdentifier] forIndexPath:indexPath];
    
    [dischCell loadDish:[self.dataSourceArray objectAtIndex:indexPath.row]];
    
    return dischCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.btRestaurants isSelected]) {
        RestaurantDetailViewController * restaurantDetail  = [[RestaurantDetailViewController alloc] initWithRestaurant:[self.dataSourceArray objectAtIndex:indexPath.row] fromMap:NO];
        
        [self.navigationController pushViewController:restaurantDetail animated:YES];
    }else {
        
        DishCollectionViewCell * dishCell = (DishCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        if (dishCell.contraint.constant == 0) {
            [AnimationHelper slideAnimationInView:dishCell.contraint withHeighDiferencial:(collectionView.frame.size.width/2)-7-40];
        }else {
            [AnimationHelper slideAnimationInView:dishCell.contraint withHeighDiferencial:0];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.btRestaurants isSelected]) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
    }
    
    return CGSizeMake((collectionView.frame.size.width/2)-8, (collectionView.frame.size.width/2)-7);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if ([self.btDishes isSelected]) {
        
        return UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    return UIEdgeInsetsZero;
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UILabelCustomization defaultAttributedTitleForLabelWithText:@"Ops... No results found!"];
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
