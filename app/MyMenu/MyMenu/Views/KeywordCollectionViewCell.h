//
//  KeywordCollectionViewCell.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCellProtocol.h"


@interface KeywordCollectionViewCell : UICollectionViewCell <CollectionViewCellProtocol>


@property (weak, nonatomic) IBOutlet UILabel        * lblKeyword;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *backView;


- (void)loadKeyword:(NSString *)keyword;

@end
