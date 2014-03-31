//
//  ADice.m
//  whalecombat
//
//  Created by anthony lamantia on 8/25/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "ADice.h"

@implementation ADice

+ (int) Roll : (int) sides
{
    return (rand() % sides) + 1;
}

@end
