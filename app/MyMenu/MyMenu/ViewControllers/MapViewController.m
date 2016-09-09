//
//  MapViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, strong) CLLocationManager     * locationManager;


@end

@implementation MapViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    nibNameOrNil = @"MapView";
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.tabBarItem.image = [UIImage imageNamed:@"ic-map"];
    self.tabBarItem.title = @"Map";
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.showsCompass = NO;
    self.mapView.showsUserLocation = YES;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
    
        [self alertViewWithTitle:@"MyMenu" cancelButtonTitle:@"OK" message:@"Message here!" andOtherButtonTitle:@"Settings"];
    }
    
    self.mapView.delegate = self;
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
   
    region.span = span;
    region.center = location;
    
    [mapView setRegion:region animated:YES];
}

@end
