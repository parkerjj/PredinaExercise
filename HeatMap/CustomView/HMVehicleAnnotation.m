//
//  HMVehicleAnnotation.m
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import "HMVehicleAnnotation.h"

@implementation HMVehicleAnnotation
@synthesize coordinate;


- (instancetype)initWithDataSource:(VehicleDataSource *)dataSource{
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
    }
    
    return self;
}


- (CLLocationCoordinate2D)coordinate{
    return self.dataSource.coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    self.dataSource.coordinate = newCoordinate;
}

@end
