//
//  NSSet+Random.m
//  HeatMap
//
//  Created by Parker on 2018/8/8.
//  Copyright © 2018年 Parker. All rights reserved.
//

#import "NSSet+Random.h"

@implementation NSSet(Random)

- (id)randomObject{
    int randomIndex = arc4random() % [self count];
    __block int currentIndex = 0;
    __block id selectedObj = nil;
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if (randomIndex == currentIndex) { selectedObj = obj; *stop = YES; }
        else currentIndex++;
    }];
    return selectedObj;
}

@end
