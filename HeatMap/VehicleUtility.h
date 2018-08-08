//
//  VehicleUtility.h
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "VehicleDataSource.h"


NS_ASSUME_NONNULL_BEGIN

@interface VehicleUtility : NSObject


/**
 *  Vehicle Utility SharedInstance
 *
 *  @return SharedInstance
 */
+ (VehicleUtility*)sharedInstance;




/**
 Get all the Data Set from given param.

 @param time Specificd time given. If null then return specific vehicleName with any time.
 @param vehicleName Specificd vehicleName given. If null then return specific time with all vehicle.
 @return NSSet
 */
- (NSSet*)filterDataSourceWithTime:(nullable NSString*)time withVehicleName:(nullable NSString*)vehicleName;


@end

NS_ASSUME_NONNULL_END
