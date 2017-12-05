//
//  YGMapManagerView.m
//  CashBack
//
//  Created by Rainy on 2017/12/4.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "YGMapManagerView.h"
#import "YGAnnotation.h"

@interface YGMapManagerView ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    LatitudeAndLongitude _latitudeAndLongitude;
    Address _address;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation YGMapManagerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self createMapView];
    }
    return self;
}
- (void)createMapView
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.bounds];
    _mapView.delegate = self;
//    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    [self addSubview:_mapView];
    
    self.locationManager = [[CLLocationManager alloc] init];
    WS(weakSelf)
    [AppUtility checkLocationServiceAuthorization:^(BOOL authorizationAllow) {
        if (!authorizationAllow) {
            
            [weakSelf.locationManager requestWhenInUseAuthorization];
        }
    }];
}
- (void)setAnnotationPins:(NSArray *)annotationPins
{
    _annotationPins = annotationPins;
    [self.mapView addAnnotations:annotationPins];
}
#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[YGAnnotation class]]) {
        
        static NSString *identifier = @"YGAnnotation";
        MKAnnotationView *annotationView =[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.canShowCallout = NO;
//            annotationView.calloutOffset = CGPointMake(0, 1);
//            annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"88"]];
            
        }
        annotationView.annotation = annotation;
        annotationView.image = ((YGAnnotation *)annotation).image;
        return annotationView;
        
    } else {
        return nil;
    }
}
- (void)getCurrentLocation:(LatitudeAndLongitude)latitudeAndLongitude
                   address:(Address)address
{
    _latitudeAndLongitude = latitudeAndLongitude;
    _address = address;
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    WS(weakSelf)
    [AppUtility checkLocationServiceAuthorization:^(BOOL authorizationAllow) {
        if (!authorizationAllow) {
            
            [weakSelf.locationManager requestWhenInUseAuthorization];
        }
    }];
    [self.locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if (error) {
        
        NSLog(@"获取当前位置失败");
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = locations[0];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            CLLocationDegrees latitude=placemark.location.coordinate.latitude;
            CLLocationDegrees longitude=placemark.location.coordinate.longitude;
            
            NSString *city = [NSString stringWithFormat:@"%@%@",placemark.administrativeArea ? placemark.administrativeArea : @"",placemark.locality ? placemark.locality : @""];
            
            NSString *adress = [NSString stringWithFormat:@"%@ %@ %@ %@",placemark.country,city,placemark.name,placemark.thoroughfare];
            
            _latitudeAndLongitude(latitude,longitude);
            _address(adress);
            
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"获取当前位置失败");
        }
        else if (error != nil)
        {
            NSLog(@"获取当前位置失败");
        }
    }];
    
    [manager stopUpdatingLocation];
    
}
+ (void)navigateTolatitude:(CLLocationDegrees)latitude
                longitude:(CLLocationDegrees)longitude
{
    MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
}
- (void)dealloc
{
    self.locationManager.delegate = nil;
    self.mapView.delegate = nil;
}

@end
