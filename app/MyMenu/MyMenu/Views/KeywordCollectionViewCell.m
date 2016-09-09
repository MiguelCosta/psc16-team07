//
//  KeywordCollectionViewCell.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "KeywordCollectionViewCell.h"
#import "UILabelCustomization.h"
#import <ChameleonFramework/Chameleon.h>


@implementation KeywordCollectionViewCell


#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"KeywordCellView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"Keyword";
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.separatorView.backgroundColor = [UIColor flatWhiteColor];
    self.backView.backgroundColor = [[UIColor flatWhiteColor] colorWithAlphaComponent:0.3];
}

- (void)loadKeyword:(NSString *)keyword {
    
    self.lblKeyword.attributedText = [UILabelCustomization defaultAttributedTextForLabelWithText:keyword];
}


@end
