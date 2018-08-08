//
//  VehicleUtility.m
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import "VehicleUtility.h"

@interface VehicleUtility(){
    NSMutableArray <VehicleDataSource*> *_vehicleDataSources;
}

@end

@implementation VehicleUtility
static VehicleUtility *_sharedInstance;
+ (void)initialize{
    [super initialize];
    if (_sharedInstance == nil) {
        _sharedInstance = [[VehicleUtility alloc] init];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _vehicleDataSources = [NSMutableArray array];
        
        [self parseVehicleDataSource];
    }
    return self;
}

+ (VehicleUtility*)sharedInstance{
    return _sharedInstance;
}


- (void)parseVehicleDataSource{
    NSURL *dataURL = [[NSBundle mainBundle] URLForResource:@"realtimelocation" withExtension:@"csv"];
    NSString *str = [NSString stringWithContentsOfURL:dataURL encoding:NSUTF8StringEncoding error:nil];
    NSArray *allLines = [str componentsSeparatedByString:@"\n"];
    
    for (NSString *lineString in allLines) {
        
        VehicleDataSource *vds = [[VehicleDataSource alloc] initWithString:lineString];
        [_vehicleDataSources addObject:vds];
        
    }
}


- (NSSet*)filterDataSourceWithTime:(NSString*)time withVehicleName:(NSString*)vehicleName{
    
    NSString *timePredicate = time==nil ? @"**" : time;
    NSString *vehicleNamePredicate = vehicleName==nil ? @"**" : vehicleName;

    NSArray *filteredArray = [_vehicleDataSources filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"time LIKE %@ AND vehicleName LIKE %@",timePredicate,vehicleNamePredicate]];
    
    if ([filteredArray count] <= 0) {
        // Didnt found
        
        return nil;
    }
    
    return [NSSet setWithArray:filteredArray];
}


@end
