//
//  MapViewController.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "MapViewController.h"
#import "SearchManager.h"
#import "Restaurant.h"
#import "RestaurantDetailViewController.h"
#import "RefineViewController.h"


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, SearchManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager     * locationManager;
@property (nonatomic, strong) SearchManager         * searchManager;
@property (nonatomic, assign) BOOL                    isFirstTime;
@property (nonatomic, strong) NSMutableDictionary   * restaurantArray;


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
    
    
    [self setTitle:@"Map"];
    
    [self navigationBarRightButtonWithImage:[UIImage imageNamed:@"ic-refine"] selectedImage:nil action:@selector(openRefine) andTarget:self];
    
    self.restaurantArray = [NSMutableDictionary dictionary];
    
    self.mapView.showsCompass = NO;
    self.mapView.showsUserLocation = YES;
    
    self.searchManager = [[SearchManager alloc] initWithDelegate:self];
    
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

- (void)openRefine {
    
    RefineViewController * refineView = [[RefineViewController alloc] init];
    
    [self.navigationController pushViewController:refineView animated:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    if (!self.isFirstTime) {
        self.isFirstTime = YES;
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
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude);
    CGFloat txtLatitude = coord.latitude;
    CGFloat txtLongitude = coord.longitude;
    
    [self.searchManager cancelAllRequests];
    [self.searchManager searchWithLatitude:[NSString stringWithFormat:@"%f", txtLatitude]  longitude:[NSString stringWithFormat:@"%f", txtLongitude] andRange:@"5"];
}

#pragma mark - SearchManager
- (void)manager:(BaseManager *)manager didFetchResults:(NSArray *)results {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.delegate = self;
        
        for (Restaurant * restaurant in results) {
            CLLocationCoordinate2D cordinates = CLLocationCoordinate2DMake([restaurant.latitude doubleValue], [restaurant.longitude doubleValue]);
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = cordinates;
            point.title = restaurant.name;
            
            NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:restaurant,@"restaurant", [NSNumber numberWithDouble:cordinates.latitude], @"latitude", [NSNumber numberWithDouble:cordinates.longitude], @"longitude", nil];
            [self.restaurantArray setObject:dict forKey:restaurant.key];
            
            [self.mapView addAnnotation:point];
        }
    });
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

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    Restaurant * restaurant = [self restaurantForLocation:view.annotation.coordinate];
    
    if (restaurant) {
        
        RestaurantDetailViewController * restaurantView = [[RestaurantDetailViewController alloc] initWithRestaurant:restaurant fromMap:YES];
        
        [self.navigationController pushViewController:restaurantView animated:YES];
    }
}

- (Restaurant *)restaurantForLocation:(CLLocationCoordinate2D)cordinates {
    
    for (NSDictionary * dic in [self.restaurantArray allValues]) {
        
        double  latitude = [[dic objectForKey:@"latitude"] doubleValue];
        double  longitude = [[dic objectForKey:@"longitude"] doubleValue];
        
        if (latitude == cordinates.latitude && longitude == cordinates.longitude) {
            return [dic objectForKey:@"restaurant"];
        }
    }
    
    return nil;
}


@end
