//
//  ViewController.m
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

/*
 
    Practical App Development Exercise
    Exercise 1-3
 
    Parker.Liu
    Email: parkerlpg@gmail.com

 */

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "HeatMapUtility.h"
#import "VehicleUtility.h"
#import "NSSet+Random.h"
#import "HMVehicleAnnotation.h"


@interface ViewController () <MKMapViewDelegate>{
    IBOutlet MKMapView *_mapView;
    NSMutableArray *_circleLayersArray;        // This is array of all heat point on the map.
    
    NSDate *_currentDate;  // Current Time. Begin with 05:00
}

@end


#if DEBUG
#define kTimeRatio 1.0f         //if Ratio is 30 then 2secs pass in real world, in app will be 1min.
#else
#define kTimeRatio 1.0f
#endif

#define kCountOfPoint 10
#define kCountOfVehicle 5



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [_mapView setDelegate:self];

    
    [self initExercise1];
    [self initExercise2];
}

#pragma mark - Exercise 1

- (void)initExercise1{
    _circleLayersArray = [NSMutableArray arrayWithCapacity:kCountOfPoint];
    
    
    NSSet *coorSet = [HeatMapUtility getRandomCoordinatesWithCount:kCountOfPoint];
    CLLocationCoordinate2D center = [HeatMapUtility centerOfCoordinatesSet:coorSet];
    [_mapView setRegion:MKCoordinateRegionMake(center, MKCoordinateSpanMake(5.0f, 5.0f)) animated:YES];
    
    [self drawCircleWithCoordinates:coorSet];
    
    
    // Start a timer for changing colors.
    NSTimer *timerForChangeColor = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreshOverlayColor) userInfo:nil repeats:YES];
    [timerForChangeColor fire];
}


- (void)drawCircleWithCoordinates:(NSSet*)coorSet{
    
    for (NSValue *value in coorSet) {
        CLLocationCoordinate2D coor = value.MKCoordinateValue;
        
        MKCircle *circleTargePlace=[MKCircle circleWithCenterCoordinate:coor radius:0];
        [_mapView addOverlay:circleTargePlace];
    }


}

- (void)refreshOverlayColor{
    for (MKCircleRenderer *renderer in _circleLayersArray) {
        renderer.strokeColor = [[HeatMapUtility getRandomColorForRender] colorWithAlphaComponent:0.7];
    }
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(nonnull id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleRenderer* renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        renderer.strokeColor = [[HeatMapUtility getRandomColorForRender] colorWithAlphaComponent:0.7];
        renderer.lineWidth = 10.0;
        
        [_circleLayersArray addObject:renderer];
        return renderer;
    }
    return nil;
}



#pragma mark - Exercise 2

- (void)initExercise2{
    
    // Date on 1970
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    _currentDate = [dateFormatter dateFromString:@"1970-01-01 05:00:00"];
    
    NSSet *set = [[VehicleUtility sharedInstance] filterDataSourceWithTime:[self getTimeFromCurrentDate] withVehicleName:nil];
    for (int i = 0; i < kCountOfVehicle; i++) {
        VehicleDataSource *vds = [set randomObject];
        [self drawVehicleWithDataSource:vds];
    }
    
    
    // Start a timer for changing location.
    NSTimer *timerForVehicle= [NSTimer scheduledTimerWithTimeInterval:60.0f/kTimeRatio target:self selector:@selector(Exercise2TimerFired) userInfo:nil repeats:YES];
    [timerForVehicle fire];
}

- (NSString*)getTimeFromCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];

    
    return [formatter stringFromDate:_currentDate];
}


- (void)drawVehicleWithDataSource:(VehicleDataSource*)vds{
    HMVehicleAnnotation *annotation = [[HMVehicleAnnotation alloc] initWithDataSource:vds];
    [_mapView addAnnotation:annotation];
}

- (void)Exercise2TimerFired{
    _currentDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMinute value:1 toDate:_currentDate options:0];
    
    for (HMVehicleAnnotation *annotation in [_mapView annotations]) {
        
        VehicleDataSource *vds = [[[VehicleUtility sharedInstance] filterDataSourceWithTime:[self getTimeFromCurrentDate] withVehicleName:annotation.dataSource.vehicleName] anyObject];
        if (vds == nil)
            return;
        
        [UIView animateWithDuration:0.3f animations:^{
            [annotation setDataSource:vds];
            
            
#warning ⚠⚠⚠⚠ See the comments below. ⚠⚠⚠⚠
            // Cause the coordinates in RealTimeLocation.csv have no change after 3-5 mins. So you can uncomment the line below to see
            // what will happened if the vehicle moved happy.  And dont forget to change kTimeRatio lager than 30.0f
            // TODO: Uncomment this. ⬇️

//            [annotation setCoordinate:CLLocationCoordinate2DMake(annotation.dataSource.coordinate.latitude + arc4random()%3, annotation.dataSource.coordinate.longitude + arc4random()%3)];
        }];
        [self->_mapView setNeedsDisplay];

    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[HMVehicleAnnotation class]])
    {
        // Reuse MKPinAnnotationView。
        MKAnnotationView *annoView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"HMVehicleAnnotationView"];
        if (!annoView)
        {
            annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"HMVehicleAnnotationView"];
            annoView.image = [UIImage imageNamed:@"vehicle"];
//            annoView.centerOffset = CGPointMake(10, -20);
            annoView.canShowCallout = NO;
            annoView.annotation = annotation;

        }
        else{
            annoView.annotation = annotation;

        }
        return annoView;
    }
    return nil;
}



@end
