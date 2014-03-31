//
//  AVector2D.m
//  whalecombat
//
//  Created by anthony lamantia on 8/25/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "AVector2D.h"

@implementation AVector2D

+ (CGPoint) Dot : (CGPoint) a  : (CGPoint) b
{
    CGPoint res;
    return res;
}

+ (CGPoint) Normal : (CGPoint) a
{
    CGPoint res;
    float length = [AVector2D Mag:a];
    res.x = a.x/length;
    res.y = a.y/length;
    return res;
}

+ (CGPoint) Add : (CGPoint) a : (CGPoint) b
{
    CGPoint res;
    res.x = a.x + b.x;
    res.y = a.y + b.y;
    return res;
}

+ (float) Mag : (CGPoint) a
{
    CGPoint res;
    res.x = powf(a.x, 2);
    res.y = powf(a.y, 2);
    return sqrtf(res.x + res.y);
}

/* direction to go to hit target */
+ (CGPoint) Sub : (CGPoint) a  : (CGPoint) b
{
    CGPoint res;
    res.x = a.x - b.x;
    res.y = a.y - b.y;
    return res;
}

+ (float) Dist : (CGPoint) a  : (CGPoint) b
{
    CGPoint res;
    res = [AVector2D Sub:a :b];
    return [AVector2D Mag:res];
}








@end
