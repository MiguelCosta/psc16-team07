//
//  MapDetailViewController.h
//  MyMenu
//
//  Created by Renata on 10/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"
#import <MapKit/MapKit.h>


@interface MapDetailViewController : AbstractViewController


@property (weak, nonatomic) IBOutlet MKMapView *mapView;


- (instancetype)initWithLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude;

@end
