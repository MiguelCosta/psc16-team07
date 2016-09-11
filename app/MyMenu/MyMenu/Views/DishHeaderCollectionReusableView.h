//
//  DishHeaderCollectionReusableView.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCellProtocol.h"


@interface DishHeaderCollectionReusableView : UICollectionReusableView <CollectionViewCellProtocol>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@end
