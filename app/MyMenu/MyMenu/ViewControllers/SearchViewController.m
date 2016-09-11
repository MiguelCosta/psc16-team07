//
//  SearchViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "SearchViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "KeywordCollectionViewCell.h"
#import "ResultsViewController.h"
#import "SearchManager.h"
#import "AnimationHelper.h"


@interface SearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SearchManagerDelegate, UITextFieldDelegate>


@property (nonatomic, strong) NSArray       * dataSourceArray;

@end

@implementation SearchViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    nibNameOrNil = @"SearchView";
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.tabBarItem.image = [UIImage imageNamed:@"ic-search"];
    self.tabBarItem.title = @"Search";
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Search"];
    
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
    self.searchView.backgroundColor = [UIColor flatWhiteColor];
    
    self.txtSearch.tintColor = [UIColor flatWatermelonColor];
    
    self.dataSourceArray = [NSArray arrayWithObjects:@"Italian", @"Mexican", @"Pasta",@"Vegetarian", @"Pizza", @"Seafood", @"Paleo", nil];
    
    [self.collectionView registerNib:[KeywordCollectionViewCell registerNib] forCellWithReuseIdentifier:[KeywordCollectionViewCell reusableIdentifier]];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.txtSearch.delegate = self;
    
    UISwipeGestureRecognizer * swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.collectionView addGestureRecognizer:swipeGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.txtSearch.text = @"";
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField.text length] != 0) {
        [self makeSearch];
    }else {
        
        [self.txtSearch resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataSourceArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KeywordCollectionViewCell * keywordCell = [collectionView dequeueReusableCellWithReuseIdentifier:[KeywordCollectionViewCell reusableIdentifier] forIndexPath:indexPath];
    
    [keywordCell loadKeyword:[self.dataSourceArray objectAtIndex:indexPath.row]];
    
    return keywordCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self makeSearchWithKeyword:[self.dataSourceArray objectAtIndex:indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KeywordCollectionViewCell * resultCell = (KeywordCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [AnimationHelper scaleAnimationfromValue:CGSizeMake(1, 1) toValue:CGSizeMake(0.95, 0.95) inView:resultCell.containerView withDelegate:nil];
    [AnimationHelper alphaAnimationInView:resultCell.backView toValue:1];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KeywordCollectionViewCell * resultCell = (KeywordCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [AnimationHelper scaleAnimationfromValue:CGSizeMake(0.95, 0.95) toValue:CGSizeMake(1, 1) inView:resultCell.containerView withDelegate:nil];
    [AnimationHelper alphaAnimationInView:resultCell.backView toValue:0];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
}

#pragma mark - Actions
- (void)makeSearchWithKeyword:(NSString *)keyword {
    
    SearchManager * searchManager = [[SearchManager alloc] initWithDelegate:self];
    
    [searchManager searchWithKeyword:keyword];
    
    [self presentWaitingView];
}

- (void)makeSearch {
    
    [self.txtSearch resignFirstResponder];
    [self makeSearchWithKeyword:self.txtSearch.text];
}

- (void)dismissKeyboard {
    
    [self.txtSearch resignFirstResponder];
}

#pragma mark - SearchManagerDelegate
- (void)manager:(BaseManager *)manager didFetchResults:(NSArray *)results forKeyword:(NSString *)keyword {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self dismissWaitingView];
        
        ResultsViewController * resultView = [[ResultsViewController alloc] initWithResults:results andKeywordSearched:keyword];
        
        [self.navigationController pushViewController:resultView animated:YES];
    });
}

#pragma mark - BaseManagerDelegate
- (void)managerDidFailed:(BaseManager *)manager withError:(NSError *)err {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self dismissWaitingView];
        
        [self alertViewWithTitle:@"MyMenu" cancelButtonTitle:@"OK" message:@"Try again later." andOtherButtonTitle:nil];
    });
}

@end
