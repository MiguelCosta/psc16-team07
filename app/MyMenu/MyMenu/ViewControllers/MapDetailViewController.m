//
//  MapDetailViewController.m
//  MyMenu
//
//  Created by Renata on 10/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "MapDetailViewController.h"

@interface MapDetailViewController () <MKMapViewDelegate>

@property (nonatomic, assign) NSNumber          * latitude;
@property (nonatomic, assign) NSNumber          * longitude;

@end

@implementation MapDetailViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:@"MapDetailView" bundle:nibBundleOrNil];
    
    return self;
}

- (instancetype)initWithLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude {
    
    self = [super init];
    
    if (self) {
        
        self.longitude = longitude;
        
        self.latitude = latitude;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Map"];
    
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D cordinates = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(cordinates, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = cordinates;
    
    [self.mapView addAnnotation:point];
}

#pragma mark - MKMapViewDelegate
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
