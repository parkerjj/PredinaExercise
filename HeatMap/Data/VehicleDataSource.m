//
//  VehicleDataSource.m
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import "VehicleDataSource.h"

@implementation VehicleDataSource

- (instancetype)initWithString:(NSString*)string{
    self = [super init];
    if (self) {
        NSArray<NSString*> *vehicleLineStrArray = [string componentsSeparatedByString:@","];
        NSAssert([vehicleLineStrArray count] == 4, @"DataSource Error \t Content: %@",string);
        
        self.time = [vehicleLineStrArray objectAtIndex:0];
        self.vehicleName = [vehicleLineStrArray objectAtIndex:1];
        self.coordinate = CLLocationCoordinate2DMake([[vehicleLineStrArray objectAtIndex:2] doubleValue], [[vehicleLineStrArray objectAtIndex:3] doubleValue]);

    }
    
    return self;
}

@end
