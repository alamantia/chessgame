//
//  CombatEnemy.h
//  whalecombat
//
//  Created by anthony lamantia on 8/25/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIDE_PLAYER  0
#define SIDE_WHITE   0
#define SIDE_ENEMY   1
#define SIDE_BLACK   1

#define SIDE_ITEM    2
#define SIDE_WALL    3

#define TYPE_PAWN    0
#define TYPE_BISHOP  1
#define TYPE_ROOK    2
#define TYPE_KNIGHT  3
#define TYPE_KING    4
#define TYPE_QUEEN   5

/* misc things */

#define TYPE_WALL    6

@interface BoardPeice : NSObject

@property (nonatomic, assign) CGPoint  location;
@property (nonatomic, assign) CGPoint  direction;
@property (nonatomic, assign) CGPoint  speed;
@property (nonatomic, assign) int      type;
@property (nonatomic, assign) int      side;
@property (nonatomic, assign) int      moveCount;
@property (nonatomic, strong) NSString *name;

- (void) Tick;
- (NSMutableArray *) getRange;

@end
