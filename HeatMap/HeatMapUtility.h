//
//  HeatMapUtility.h
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface HeatMapUtility : NSObject





/**
 Get random coordinates from Coordinates.csv

 @param count How many of coordinates you want
 @return Coordinates NSSet<NSValue <CLLocationCoordinate2D> >
 */
+ (NSSet*)getRandomCoordinatesWithCount:(NSUInteger)count;





/**
 Get the Center Point of the coordinates

 @param coordinatesSet Coordinates Set (NSSet<NSValue <CLLocationCoordinate2D> >)
 @return Center Point
 */
+ (CLLocationCoordinate2D)centerOfCoordinatesSet:(NSSet*)coordinatesSet;



/**
 Get the random color shows on map

 @return Random UIColor
 */
+ (UIColor*)getRandomColorForRender;

@end

NS_ASSUME_NONNULL_END
