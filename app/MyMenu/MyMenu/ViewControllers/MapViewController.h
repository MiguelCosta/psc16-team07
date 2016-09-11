//
//  MapViewController.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "AbstractViewController.h"
#import <MapKit/MapKit.h>


@interface MapViewController : AbstractViewController


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
