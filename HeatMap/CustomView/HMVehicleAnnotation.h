//
//  HMVehicleAnnotation.h
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "VehicleDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMVehicleAnnotation : NSObject <MKAnnotation>{

}

@property (nonatomic, strong) VehicleDataSource *dataSource;

- (instancetype)initWithDataSource:(VehicleDataSource*)dataSource;


@end

NS_ASSUME_NONNULL_END
