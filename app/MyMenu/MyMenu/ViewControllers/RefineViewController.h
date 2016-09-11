//
//  RefineViewController.h
//  MyMenu
//
//  Created by Renata on 10/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"

@interface RefineViewController : AbstractViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *lblPriceTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTypeTitle;
@property (weak, nonatomic) IBOutlet UIButton *btIndian;
@property (weak, nonatomic) IBOutlet UILabel *lblIndian;
@property (weak, nonatomic) IBOutlet UILabel *lblMexican;
@property (weak, nonatomic) IBOutlet UIButton *btMexican;
@property (weak, nonatomic) IBOutlet UIButton *btItalian;
@property (weak, nonatomic) IBOutlet UILabel *lblItalian;
@property (weak, nonatomic) IBOutlet UILabel *lblJapanese;
@property (weak, nonatomic) IBOutlet UIButton *btJapanese;
@property (weak, nonatomic) IBOutlet UILabel *lblTraditional;
@property (weak, nonatomic) IBOutlet UIButton *btTraditional;
@property (weak, nonatomic) IBOutlet UILabel *lblSeafood;
@property (weak, nonatomic) IBOutlet UIButton *btSeafood;
@property (weak, nonatomic) IBOutlet UIButton *btRefine;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPriceValue;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceValue;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UISlider *priceSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblOvo;
@property (weak, nonatomic) IBOutlet UILabel *lblLacto;
@property (weak, nonatomic) IBOutlet UILabel *lblPaleo;
@property (weak, nonatomic) IBOutlet UILabel *lblVegan;
@property (weak, nonatomic) IBOutlet UILabel *lblFish;
@property (weak, nonatomic) IBOutlet UILabel *lblVegetarian;
@property (weak, nonatomic) IBOutlet UILabel *lblDiet;
@end
