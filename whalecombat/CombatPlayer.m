//
//  CombatPlayer.m
//  whalecombat
//
//  Created by anthony lamantia on 8/25/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "CombatPlayer.h"

@implementation CombatPlayer
@synthesize  location, name, direction, speed;

- (NSArray *) getValidMoves
{
    return nil;
}

- (NSMutableArray *) getRange
{
    NSMutableArray *range = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *moveDict;
    
    /* return the relevtive positions this peice can move    */
    /* the idea is that these will be upgraded in the future */
    /* and a decent ruleset can be followed                  */

    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [range addObject: moveDict];
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"y"];
    [range addObject: moveDict];
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"y"];
    [range addObject: moveDict];
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"y"];
    [range addObject: moveDict];
        
    return range;
}

@end
