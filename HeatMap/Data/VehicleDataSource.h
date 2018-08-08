//
//  VehicleDataSource.h
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleDataSource : NSObject



- (instancetype)initWithString:(NSString*)string;

@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *vehicleName;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

NS_ASSUME_NONNULL_END
