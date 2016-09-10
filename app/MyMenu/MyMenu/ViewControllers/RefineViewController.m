//
//  RefineViewController.m
//  MyMenu
//
//  Created by Renata on 10/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "RefineViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "UILabelCustomization.h"
#import "SearchManager.h"
#import "ResultsViewController.h"


@interface RefineViewController () <SearchManagerDelegate>

@property (nonatomic, strong) NSMutableArray        * keywordArray;
@property (nonatomic, strong) NSMutableArray        * typesArray;

@end

@implementation RefineViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:@"RefineView" bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.keywordArray = [NSMutableArray array];
    self.typesArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor flatWhiteColor];
    
    self.containerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.containerView.frame.size.height);
    
    [self.scrollView addSubview:self.containerView];
    [self.scrollView setContentSize:_containerView.frame.size];
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    
    self.lblPriceTitle.attributedText = [UILabelCustomization defaultAttributedTitleForLabelWithText:@"PRICE"];
    
    self.lblTypeTitle.attributedText = [UILabelCustomization defaultAttributedTitleForLabelWithText:@"TYPE"];
    self.lblPrice.attributedText = [UILabelCustomization defaultAttributedTitleForLabelWithText:@"DISTANCE"];
    self.lblDiet.attributedText = [UILabelCustomization defaultAttributedTitleForLabelWithText:@"DIET"];
    
    
    [self.btRefine setAttributedTitle:[UILabelCustomization defaultWhiteAttributedTitleForLabelWithText:@"Refine"] forState:UIControlStateNormal];
    self.btRefine.layer.cornerRadius = 2.0;
    
    self.lblIndian.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Indian"];
    self.lblMexican.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Mexican"];
    self.lblItalian.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Italian"];
    self.lblJapanese.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Japanese"];
    self.lblTraditional.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Traditional"];
    self.lblSeafood.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Chinese"];
    
    self.lblOvo.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Egg Vegetarian"];
    self.lblLacto.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Lacto Vegetarian"];
    self.lblPaleo.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Paleo"];
    self.lblVegetarian.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Vegetarian"];
    self.lblFish.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Pescetarian"];
    self.lblVegan.attributedText = [UILabelCustomization defaultBlackAttributedDescriptionForLabelWithText:@"Vegan"];
    
    [self setTitle:@"Refine"];
    
    self.lblPriceValue.attributedText = [UILabelCustomization defaultAttributedDescriptionForLabelWithText:[NSString stringWithFormat:@"%0.2f", self.priceSlider.value]];
    self.lblDistanceValue.attributedText = [UILabelCustomization defaultAttributedDescriptionForLabelWithText:[NSString stringWithFormat:@"%0.2f", self.distanceSlider.value]];
}

#pragma mark - IBActions
- (IBAction)priceSliderDidChanged:(id)sender {
    
    self.lblPriceValue.attributedText = [UILabelCustomization defaultAttributedDescriptionForLabelWithText:[NSString stringWithFormat:@"%0.2f", self.priceSlider.value]];
}

- (IBAction)distanceSliderDidChanged:(id)sender {
    
    self.lblDistanceValue.attributedText = [UILabelCustomization defaultAttributedDescriptionForLabelWithText:[NSString stringWithFormat:@"%0.2f", self.distanceSlider.value]];
}

- (IBAction)indianAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.typesArray removeObject:@"Indian"];
    }else {
        [self.typesArray addObject:@"Indian"];
    }
    
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)mexicanAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.typesArray removeObject:@"Mexican"];
    }else {
        [self.typesArray addObject:@"Mexican"];
    }
    
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)italianAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.typesArray removeObject:@"Italian"];
    }else {
        [self.typesArray addObject:@"Italian"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)japaneseAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.typesArray removeObject:@"Japanese"];
    }else {
        [self.typesArray addObject:@"Japanese"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)traditionalAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.typesArray removeObject:@"Traditional"];
    }else {
        [self.typesArray addObject:@"Traditional"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)chineseAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.typesArray removeObject:@"Chinese"];
    }else {
        [self.typesArray addObject:@"Chinese"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)ovoAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.keywordArray removeObject:@"Egg Vegetarian"];
    }else {
        [self.keywordArray addObject:@"Egg Vegetarian"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)lactoAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.keywordArray removeObject:@"Lacto Vegetarian"];
    }else {
        [self.keywordArray addObject:@"Lacto Vegetarian"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)paleoAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.keywordArray removeObject:@"Paleo"];
    }else {
        [self.keywordArray addObject:@"Paleo"];
    }
    [sender setSelected:![sender isSelected]];
}

- (IBAction)vegetarianAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.keywordArray removeObject:@"Vegetarian"];
    }else {
        [self.keywordArray addObject:@"Vegetarian"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)fishAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.keywordArray removeObject:@"Pescetarian"];
    }else {
        [self.keywordArray addObject:@"Pescetarian"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)veganAction:(id)sender {
    
    if ([sender isSelected]) {
        [self.keywordArray removeObject:@"Vegan"];
    }else {
        [self.keywordArray addObject:@"Vegan"];
    }
    
    [sender setSelected:![sender isSelected]];
}

- (IBAction)refineAction:(id)sender {
    
    SearchManager * searchManager = [[SearchManager alloc] initWithDelegate:self];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.keywordArray, @"keywords", [NSNumber numberWithFloat:self.priceSlider.value], @"maxPrice", self.typesArray, @"types", nil];
    
    [searchManager refineSearch:dict withLatitude:nil longitude:nil andRange:[NSString stringWithFormat:@"%f", self.distanceSlider.value]];
    
    [self presentWaitingView];
}

#pragma mark - SearchManagerDelegate
- (void)manager:(BaseManager *)manager didFetchResults:(NSArray *)results forKeyword:(NSString *)keyword {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self dismissWaitingView];
        
        UIViewController * viewController = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        
        if ([viewController isKindOfClass:[ResultsViewController class]]) {
            [(ResultsViewController *)viewController refineWithResults:results];
        }
        
        [self.navigationController popToViewController:viewController animated:YES];
    });
}
@end
