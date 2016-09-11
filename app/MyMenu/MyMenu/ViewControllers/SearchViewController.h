//
//  SearchViewController.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"


@interface SearchViewController : AbstractViewController


@property (weak, nonatomic) IBOutlet UICollectionView   * collectionView;
@property (weak, nonatomic) IBOutlet UIView             * searchView;
@property (weak, nonatomic) IBOutlet UITextField        * txtSearch;


@end
