//
//  CombatEnemy.m
//  whalecombat
//
//  Created by anthony lamantia on 8/25/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "BoardPeice.h"
#import "AppDelegate.h"
#import "TileView.h"
#import "CombatViewController.h"

@implementation BoardPeice

@synthesize  location, name, direction, speed, type, side;

- (id) init {
    self = [super init];
    self.type = 1;
    self.moveCount = 0;
    return self;
}
- (void) Tick
{
    return;
}


- (NSMutableArray *) pawnRange
{
    NSMutableArray *range = [[NSMutableArray alloc] init];
    NSMutableDictionary *moveDict;
    /* return the relevtive positions this peice can move    */
    /* the idea is that these will be upgraded in the future */
    /* and a decent ruleset can be followed                  */
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    CombatViewController *combatVc = del.combatVc;
    BoardPeice *currentPeice;
    if (self.moveCount == 0) {
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:2] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:NO]  forKey:@"can_capture"];
        currentPeice = [combatVc getPeiceAtTile:location.x + 0 : location.y + 2];
        if (currentPeice == nil) {
            [range addObject: moveDict];
        }
    }
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:NO]  forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + 0 : location.y + 1];
    if (currentPeice == nil) {
        [range addObject: moveDict];
    }
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];    
    currentPeice = [combatVc getPeiceAtTile:location.x +1 : location.y + 1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    }
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES] forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + -1 : location.y + 1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    }
    return range;
}


- (NSMutableArray *) knightRange
{
    NSMutableArray *range = [[NSMutableArray alloc] init];
    NSMutableDictionary *moveDict;
    /* return the relevtive positions this peice can move    */
    /* the idea is that these will be upgraded in the future */
    /* and a decent ruleset can be followed                  */
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:2] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
    
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    CombatViewController *combatVc = del.combatVc;
    BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + -1 : location.y + -2];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {

        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }

    
    
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:2] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];

    currentPeice = [combatVc getPeiceAtTile:location.x + 1 : location.y + 2];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {
            
        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }

    
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-2] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];

    currentPeice = [combatVc getPeiceAtTile:location.x + 1 : location.y + -2];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {
            
        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }

    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-2] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + -1 : location.y + -2];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {
            
        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:2] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];

    currentPeice = [combatVc getPeiceAtTile:location.x + 2 : location.y + 1];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {
            
        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:2] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];

    currentPeice = [combatVc getPeiceAtTile:location.x + 2 : location.y + -1];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {
            
        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-2] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
    
    currentPeice = [combatVc getPeiceAtTile:location.x + -2 : location.y + -1];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {
            
        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }

    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-2] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];

    currentPeice = [combatVc getPeiceAtTile:location.x + -2 : location.y + 1];
    if (currentPeice != nil) {
        if (currentPeice.side == SIDE_PLAYER) {
            
        } else {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    return range;
}

- (NSMutableArray *) rookRange
{
    NSMutableArray *range = [[NSMutableArray alloc] init];
    NSMutableDictionary *moveDict;

    int ix = 0;
    int iy = 0;
    
    ix = 0;
    iy = 0;
    for (int ix = 0; ix >= -8; ix--) {
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
      
        
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];

        if (currentPeice != nil) {
            if (currentPeice == self)
                continue;
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }
        [range addObject: moveDict];
    }
    
    ix = 0;
    iy = 0;
    
    for (int ix = 0; ix < 8; ix++) {
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
        
        
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];
        
        if (currentPeice != nil) {
            if (currentPeice == self)
                continue;
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }
        [range addObject: moveDict];
    }
    
    ix = 0;
    iy = 0;
    for (int iy = 0; iy < 8; iy++) {
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
        
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];
        
        if (currentPeice != nil) {
            if (currentPeice == self)
                continue;
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }
        [range addObject: moveDict];
    }


    
    ix = 0;
    iy = 0;
    for (int iy = 0; iy > -8; iy--) {
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
     
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];
        
        if (currentPeice != nil) {
            if (currentPeice == self)
                continue;
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }

        
        [range addObject: moveDict];
    }

    return range;
}


- (NSMutableArray *) bishopRange
{
    NSMutableArray *range = [[NSMutableArray alloc] init];
    NSMutableDictionary *moveDict;

    int ix = 0 ;
    int iy = 0;
    
    ix = 0;
    iy = 0;
    for (int i = -8; i < 8; i++) {
        ix++;
        iy++;
        
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
        
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];
        if (currentPeice != nil) {
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }
        [range addObject: moveDict];
    }
    
    ix = 0;
    iy = 0;
    
    for (int i = -8; i < 8; i++) {
        ix--;
        iy--;
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];
        if (currentPeice != nil) {
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }
        [range addObject: moveDict];
    }
    
    
    ix = 0;
    iy = 0;
    
    for (int i = -8; i < 8; i++) {
        ix++;
        iy--;
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];
        if (currentPeice != nil) {
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }
        [range addObject: moveDict];
    }

    ix = 0;
    iy = 0;
    
    for (int i = -8; i < 8; i++) {
        ix--;
        iy++;
        moveDict = [[NSMutableDictionary alloc] init];
        [moveDict setValue:[NSNumber numberWithInt:ix] forKey:@"x"];
        [moveDict setValue:[NSNumber numberWithInt:iy] forKey:@"y"];
        [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
        [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        CombatViewController *combatVc = del.combatVc;
        BoardPeice *currentPeice = [combatVc getPeiceAtTile:location.x + ix : location.y + iy];
        if (currentPeice != nil) {
            if (currentPeice.side == SIDE_PLAYER) {
                break;
            } else {
                [range addObject: moveDict];
                break;
            }
        }
        [range addObject: moveDict];
    }
    return range;
}


- (NSMutableArray *) kingRange
{
    NSMutableArray *range = [[NSMutableArray alloc] init];
    NSMutableDictionary *moveDict;
    
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    CombatViewController *combatVc = del.combatVc;
    BoardPeice *currentPeice;


    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];

    currentPeice = [combatVc getPeiceAtTile:location.x + 0 : location.y + 1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }

    
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + 0 : location.y + -1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }


    
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + -1 : location.y + -1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }

    

    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-0] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + 0 : location.y + 0];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]   forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES]  forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + 1 : location.y + 1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]  forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES] forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + -1 : location.y + 1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]  forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES] forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + 1 : location.y + 0];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:0] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]  forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES] forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + -1 : location.y + 0];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    moveDict = [[NSMutableDictionary alloc] init];
    [moveDict setValue:[NSNumber numberWithInt:1] forKey:@"x"];
    [moveDict setValue:[NSNumber numberWithInt:-1] forKey:@"y"];
    [moveDict setValue:[NSNumber numberWithBool:NO]  forKey:@"capture_only"];
    [moveDict setValue:[NSNumber numberWithBool:YES] forKey:@"can_capture"];
    currentPeice = [combatVc getPeiceAtTile:location.x + 1 : location.y + -1];
    if (currentPeice != nil) {
        if (currentPeice.side != SIDE_PLAYER) {
            [range addObject: moveDict];
        }
    } else {
        [range addObject: moveDict];
    }
    return range;
}

- (NSMutableArray *) queenRange
{
    NSMutableArray *range = [[NSMutableArray alloc] init];
    
    [range addObjectsFromArray:[self bishopRange]];
    [range addObjectsFromArray:[self rookRange]];
    return range;
}
/* capture only means a peice can only make this move on a capturing move */
- (NSMutableArray *) getRange
{
    
    if (self.type == TYPE_PAWN) {
        return [self pawnRange];
    }
    
    if (self.type == TYPE_KNIGHT) {
        return  [self knightRange];
    }
    
    if (self.type == TYPE_ROOK) {
        return [self rookRange];
    }
    
    if (self.type == TYPE_BISHOP) {
        return [self bishopRange];
    }
    
    if (self.type == TYPE_KING) {
        return [self kingRange];
    }
    
    if (self.type == TYPE_QUEEN) {
        return [self queenRange];
    }
    
    return [self pawnRange];
}

@end
