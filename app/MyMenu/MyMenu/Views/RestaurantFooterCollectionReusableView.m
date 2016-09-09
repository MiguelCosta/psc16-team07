//
//  RestaurantFooterCollectionReusableView.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "RestaurantFooterCollectionReusableView.h"
#import "Restaurant.h"
#import <MapKit/MapKit.h>


@implementation RestaurantFooterCollectionReusableView


#pragma mark - CollectionViewCellProtocol
+ (UINib *)registerNib {
    
    UINib * restaurantNib = [UINib nibWithNibName:@"RestaurantFooterReusableView" bundle:nil];
    
    return restaurantNib;
}

+ (NSString *)reusableIdentifier {
    
    return @"Footer";
}

- (void)updateRestaurantPosition:(Restaurant *)restaurant {
    
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D cordinates = CLLocationCoordinate2DMake([restaurant.latitude doubleValue], [restaurant.longitude doubleValue]);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(cordinates, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = cordinates;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if(annotation != self.mapView.userLocation) {
        static NSString *defaultPinID = @"pin";
        pinView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.canShowCallout = YES;
        pinView.image = [UIImage imageNamed:@"ic-pin"];
    }
    
    return pinView;
}

@end
