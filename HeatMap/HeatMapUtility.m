//
//  HeatMapUtility.m
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import "HeatMapUtility.h"
#import <MapKit/MapKit.h>


@implementation HeatMapUtility




+ (NSSet*)getRandomCoordinatesWithCount:(NSUInteger)count{
    
    NSMutableSet *mSet = [NSMutableSet setWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            NSString *lineStr = [HeatMapUtility randomLineFromCoordinatesCVS];
            NSArray<NSString*> *coorStrArray = [lineStr componentsSeparatedByString:@","];
            CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([[coorStrArray firstObject] doubleValue], [[coorStrArray lastObject] doubleValue]);
            NSValue *value = [NSValue valueWithMKCoordinate:coor];
            [mSet addObject:value];
        }
    }
    
    
    return [NSSet setWithSet:mSet];
}

+ (NSString*)randomLineFromCoordinatesCVS{
    
    //TODO: There will be a better way to read this large csv file to save memory.
    // Like stream and search '\n'.
    
    NSURL *coorURL = [[NSBundle mainBundle] URLForResource:@"Coordinates" withExtension:@"csv"];
    NSString *str = [NSString stringWithContentsOfURL:coorURL encoding:NSUTF8StringEncoding error:nil];
    NSArray *allLines = [str componentsSeparatedByString:@"\n"];
    
    int line = arc4random() % [allLines count];
    
    return [allLines objectAtIndex:line];
    
}



+ (CLLocationCoordinate2D)centerOfCoordinatesSet:(NSSet*)coordinatesSet{
    NSAssert(coordinatesSet != nil, @"Coordinates Set cannot be null.");
    NSAssert([coordinatesSet count] > 0, @"Coordinates Set cannot be empty.");

    double sumLatitude = 0.0f;
    double sumLongitude = 0.0f;
    
    for (NSValue *value in coordinatesSet) {
        CLLocationCoordinate2D coor = value.MKCoordinateValue;
        sumLatitude += coor.latitude;
        sumLongitude += coor.longitude;
    }
    
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(sumLatitude/[coordinatesSet count], sumLongitude/[coordinatesSet count]);
    
    return coor;
}

+ (UIColor*)getRandomColorForRender{
    UIColor *color;
    int heat = arc4random() % 10+1;
    if (heat <= 2) {
        // Green
        color = [UIColor greenColor];
    }else if (heat <= 5){
        // Yellow
        color = [UIColor yellowColor];
    }else if (heat <= 8){
        // Orange
        color = [UIColor orangeColor];
    }else{
        // Red
        color = [UIColor redColor];
    }
    
    return color;
}

@end
